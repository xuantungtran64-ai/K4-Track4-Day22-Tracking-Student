# Báo cáo lab: chọn tracker cho 5 video

**Nhóm:** Nhóm 01 **Thành viên:** Mai Hương

Detector cố định: `yolo26n.pt`, ảnh 640 px, Re-ID `osnet_x0_25_msmt17`. Không đổi các mục này trong bài nộp chính.

## 1. Cấu hình đã chọn

Mỗi video: tracker bạn nộp, `conf`, `iou`, điều bạn **nhìn thấy** trên video, và một cấu hình đã thử rồi loại.

| Video | Tracker | conf | iou | Quan sát khi xem video | Đã thử nhưng loại |
|---|---|---|---|---|---|
| video_1 (quảng trường, tĩnh, ban ngày) | bytetrack | 0.3 | 0.5 | Ít người, khung cảnh sáng, tracker giữ ID tốt khi đi thẳng. Thi thoảng có người bị che khuất nhẹ nhưng ByteTrack vẫn nối lại được. | botsort (do ByteTrack chạy nhanh và đủ tốt, không cần Re-ID tốn tài nguyên) |
| video_2 (phố đêm, tĩnh, rất đông) | strongsort | 0.2 | 0.5 | Cảnh tối và rất đông, nhiễu. conf thấp giúp không sót người. StrongSORT dùng Re-ID mạnh giúp không bị nhảy ID khi người đi sát nhau (cross). | bytetrack (hay bị nhảy ID do chỉ dựa trên khoảng cách giữa các khung hình, cảnh đông dễ loạn) |
| video_3 (camera di động, ảnh nhỏ) | deepocsort | 0.25 | 0.5 | Camera di động nên nền bị dịch chuyển. Re-ID của deepocsort giúp bắt đúng đối tượng dù kích thước người nhỏ và vị trí lệch nhanh. | ocsort (thỉnh thoảng mất ID do không có đặc trưng ngoại hình khi FPS bị giật hoặc camera lia nhanh) |
| video_4 (trong nhà, camera di chuyển) | botsort | 0.3 | 0.5 | Kính trong nhà tạo bóng, camera tiến tới làm thay đổi góc nhìn. BoTSORT dựa vào bù chuyển động (camera motion) và Re-ID tốt giúp tránh bắt nhầm bóng trên kính. | bytetrack (có hiện tượng bắt nhầm bóng hoặc mất ID khi người đổi góc) |
| video_5 (trên xe bus, giao lộ đông) | strongsort | 0.25 | 0.4 | Xe bus rung lắc rất mạnh và xe chạy nhanh ở giao lộ. ID rất dễ rơi rụng nếu chỉ dùng Kalman Filter. Re-ID phát huy tác dụng rõ rệt. | ocsort (mất track nhiều khi rung lắc) |

## 2. Số liệu video_1

Dán bảng HOTA / MOTA / IDF1 do `scripts/evaluate_practice.py` in ra.

```
HOTA: nop_bai_v1-pedestrian        HOTA      DetA      AssA      DetRe     DetPr     AssRe     AssPr     LocA      OWTA      HOTA(0)   LocA(0)   HOTALocA(0)
video_1                            26.912    15.068    48.13     15.288    82.599    50.467    84.841    84.551    27.116    32.559    81.385    26.498    

CLEAR: nop_bai_v1-pedestrian       MOTA      MOTP      MODA      CLR_Re    CLR_Pr    MTR       PTR       MLR       sMOTA     CLR_TP    CLR_FN    CLR_FP    IDSW      MT        PT        ML        Frag      
video_1                            17.292    82.526    17.356    17.932    96.889    11.29     14.516    74.194    14.158    3332      15249     107       12        7         9         46        44        

Identity: nop_bai_v1-pedestrian    IDF1      IDR       IDP       IDTP      IDFN      IDFP      
video_1                            25.713    15.236    82.32     2831      15750     608       
```

`video_2` đến `video_5` không có nhãn trong gói lab. Không điền số cho các video đó.

## 3. Phân tích

Với **ít nhất hai video** (nên gồm một video bạn chỉ đánh giá bằng mắt), viết 3–5 câu:

- Với `video_2` (phố đêm rất đông), tôi nhận thấy ByteTrack dễ làm ID nhảy từ người này sang người khác khi họ đi cắt ngang nhau. Do đó, việc đổi sang StrongSORT giúp kết hợp trích xuất đặc trưng ngoại hình (Re-ID), giữ ID bám đúng người hơn dù bị che lấp chốc lát.
- Với `video_5` (xe bus rung lắc), sự rung động của khung hình làm Kalman Filter thuần tuý bị sai lệch lớn trong dự đoán vị trí. StrongSORT bù đắp được nhờ dùng Re-ID để so sánh ngoại hình, nên tracker vẫn duy trì được danh tính đúng kể cả khi dự đoán vị trí hình học sai số lớn.

## 4. Nếu có thêm thời gian

Tôi sẽ thử nghiệm lưới tham số `conf` từ 0.1 đến 0.5 chi tiết hơn cho `video_2` (cảnh tối) để cân bằng giữa lượng hộp giả và người bị bỏ sót. Đồng thời xem xét áp dụng BoTSORT cho tất cả các video bị di chuyển camera do có tính năng bù chuyển động (GMC).

