# Quantum-Bell-State-FPGA-demo-using-Verilog-on-Vivado
 FPGA Quantum Bell State Demo bằng Verilog trên Vivado
# FPGA Quantum Bell State Demo bằng Verilog trên Vivado

## 1. Giới thiệu dự án

Đây là dự án mô phỏng một hệ lượng tử đơn giản trên FPGA bằng **Verilog HDL** và triển khai trên **Xilinx Vivado**. Mục tiêu của dự án là xây dựng một mô hình phần cứng có khả năng biểu diễn trạng thái của qubit, thực hiện các cổng lượng tử cơ bản, và tạo ra **Bell state** cho hệ 2 qubit.

Dự án không nhằm xây dựng một máy tính lượng tử thật, mà là **một bộ mô phỏng trạng thái lượng tử bằng phần cứng số cổ điển**. Nói cách khác, FPGA trong đề tài này đóng vai trò như một **quantum state emulator**, tức là dùng phần cứng số để biểu diễn và cập nhật trạng thái lượng tử theo các phép biến đổi toán học.

Bài toán trung tâm của dự án là thực hiện chuỗi biến đổi:

\[
|00\rangle
\xrightarrow{H \text{ trên qubit 1}}
\frac{1}{\sqrt{2}} \left( |00\rangle + |10\rangle \right)
\xrightarrow{CNOT}
\frac{1}{\sqrt{2}} \left( |00\rangle + |11\rangle \right)
\]

Trạng thái cuối cùng:

\[
\frac{1}{\sqrt{2}} \left( |00\rangle + |11\rangle \right)
\]

là một **Bell state**, tức là một trạng thái rối lượng tử điển hình của hệ 2 qubit.

---

## 2. Mục tiêu của dự án

Dự án được xây dựng với các mục tiêu chính sau:

- Hiểu cách biểu diễn **qubit** và **hệ nhiều qubit** trong miền phần cứng số.
- Xây dựng các **khối Verilog cơ bản** để xử lý số phức fixed-point.
- Hiện thực các **cổng lượng tử cơ bản** như X, Z, H và CNOT.
- Ghép các khối lại thành một pipeline hoàn chỉnh tạo ra **Bell state**.
- Mô phỏng trên Vivado để kiểm tra dạng sóng.
- Tổng hợp, đặt phần tử, đi dây, và đánh giá timing của thiết kế trên FPGA.

---

## 3. Qubit là gì?

### 3.1. Bit cổ điển

Trong máy tính thông thường, đơn vị thông tin cơ bản là **bit**. Một bit chỉ có thể nhận một trong hai giá trị:

- `0`
- `1`

Điều đó có nghĩa là tại một thời điểm, bit chỉ ở đúng một trạng thái xác định.

### 3.2. Qubit

Trong tính toán lượng tử, đơn vị thông tin cơ bản là **qubit**. Khác với bit cổ điển, qubit có thể tồn tại ở trạng thái chồng chập giữa `|0⟩` và `|1⟩`.

Trạng thái tổng quát của một qubit được viết là:

\[
|\psi\rangle = \alpha |0\rangle + \beta |1\rangle
\]

Trong đó:

- \(\alpha\) là biên độ phức của trạng thái `|0⟩`
- \(\beta\) là biên độ phức của trạng thái `|1⟩`

Hai giá trị \(\alpha\) và \(\beta\) thường là **số phức**, và phải thỏa điều kiện chuẩn hóa:

\[
|\alpha|^2 + |\beta|^2 = 1
\]

### 3.3. Ý nghĩa của chồng chập

Chồng chập không có nghĩa là qubit “vừa là 0 vừa là 1” theo kiểu trực giác đơn giản, mà có nghĩa là hệ được mô tả bằng một tổ hợp tuyến tính của hai trạng thái cơ sở. Khi đo, xác suất thu được:

- `|0⟩` là \(|\alpha|^2\)
- `|1⟩` là \(|\beta|^2\)

---

## 4. Biểu diễn qubit trong project này

Vì \(\alpha\) và \(\beta\) là số phức, nên trong phần cứng số ta phải lưu riêng:

- phần thực của \(\alpha\)
- phần ảo của \(\alpha\)
- phần thực của \(\beta\)
- phần ảo của \(\beta\)

Do đó, một qubit được biểu diễn bằng 4 giá trị:

- `alpha_re`
- `alpha_im`
- `beta_re`
- `beta_im`

Trong project này, các giá trị này được biểu diễn dưới dạng **fixed-point signed**, để thuận tiện khi hiện thực trên FPGA.

---

## 5. Hệ 2 qubit là gì?

Với 2 qubit, hệ không còn chỉ có 2 trạng thái cơ sở nữa mà có 4 trạng thái cơ sở:

\[
|00\rangle,\ |01\rangle,\ |10\rangle,\ |11\rangle
\]

Trạng thái tổng quát của hệ 2 qubit là:

\[
|\psi\rangle
=
a_{00}|00\rangle
+
a_{01}|01\rangle
+
a_{10}|10\rangle
+
a_{11}|11\rangle
\]

Trong đó:

- \(a_{00}\), \(a_{01}\), \(a_{10}\), \(a_{11}\) là các biên độ phức.

Vì mỗi biên độ là số phức, nên hệ 2 qubit phải lưu:

- `a00_re`, `a00_im`
- `a01_re`, `a01_im`
- `a10_re`, `a10_im`
- `a11_re`, `a11_im`

Tổng cộng là **8 giá trị fixed-point**.

---

## 6. Bell state là gì?

Bell state là một lớp trạng thái rối lượng tử đơn giản nhưng rất quan trọng. Trong dự án này, Bell state mục tiêu là:

\[
|\Phi^+\rangle = \frac{1}{\sqrt{2}} \left( |00\rangle + |11\rangle \right)
\]

Đây là trạng thái mà hai qubit không còn được mô tả riêng rẽ một cách độc lập nữa. Hệ phải được xem như một thực thể chung.

Bell state là ví dụ điển hình để minh họa:

- superposition
- entanglement
- tác dụng của cổng Hadamard và CNOT

---

## 7. Ý tưởng mô phỏng lượng tử bằng FPGA

FPGA không phải phần cứng lượng tử. FPGA là phần cứng số cổ điển. Vì vậy, để mô phỏng lượng tử trên FPGA, ta không thực hiện cơ chế vật lý lượng tử thật, mà chỉ hiện thực **các phép biến đổi toán học trên vector trạng thái**.

Nói cách khác:

- trạng thái qubit được lưu dưới dạng số fixed-point
- các cổng lượng tử được hiện thực dưới dạng biến đổi đại số tuyến tính
- các thanh ghi giữ trạng thái trung gian giữa các tầng xử lý

Đây là ý tưởng cốt lõi của **quantum state emulation** trên FPGA.

---

## 8. Biểu diễn số fixed-point

### 8.1. Vì sao dùng fixed-point?

FPGA làm việc tốt với số nguyên và fixed-point hơn floating-point nếu muốn thiết kế đơn giản, ít tài nguyên và dễ kiểm soát timing. Vì vậy dự án này chọn biểu diễn các biên độ lượng tử bằng **fixed-point có dấu**.

### 8.2. Ý nghĩa

Ví dụ nếu cấu hình kiểu **Q2.14** thì:

- 1 bit dấu
- 1 bit phần nguyên
- 14 bit phần thập phân

Một số giá trị thường gặp:

- `1.0` → `16384`
- `0.5` → `8192`
- `1/sqrt(2)` → xấp xỉ `11585`
- `0` → `0`

---

## 9. Cấu trúc tổng thể của project

Pipeline chính của hệ là:

\[
|00\rangle
\rightarrow REG0
\rightarrow H \text{ trên qubit 1}
\rightarrow REG1
\rightarrow CNOT
\rightarrow REG2
\]

Trong project, điều này được ghép thành:

- khối khởi tạo trạng thái đầu vào
- thanh ghi trạng thái 2 qubit đầu tiên
- khối Hadamard tác động lên qubit 1
- thanh ghi trạng thái sau H
- khối CNOT
- thanh ghi trạng thái cuối cùng

---

## 10. Cấu trúc file của project

Ví dụ cây thư mục có thể trình bày như sau:

```text
.
├── qcfg_defs.vh
├── cpx_add.v
├── cpx_sub.v
├── cpx_neg.v
├── fxp_mul_k_inv_sqrt2.v
├── qstate_1q_reg.v
├── qgate_x_1q.v
├── qgate_z_1q.v
├── qgate_h_1q.v
├── qstate_2q_reg.v
├── qstate_bell_init.v
├── qgate_cnot_2q.v
├── top_bell_demo.v
├── tb_qgate_x_1q.v
├── tb_qgate_z_1q.v
├── tb_qgate_h_1q.v
├── tb_qgate_cnot_2q.v
└── tb_top_bell_demo.v
