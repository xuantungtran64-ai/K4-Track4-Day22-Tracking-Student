"""Unit tests cho file run_tracking.py"""

from run_tracking import color_for_id

def test_color_for_id_consistency():
    """Cùng một ID phải sinh ra cùng một mã màu."""
    color1 = color_for_id(5)
    color2 = color_for_id(5)
    assert color1 == color2, "Màu phải luôn thống nhất cho cùng một track_id"

def test_color_for_id_difference():
    """Hai ID khác nhau nên sinh ra mã màu khác nhau."""
    color1 = color_for_id(1)
    color2 = color_for_id(2)
    assert color1 != color2, "Hai track_id khác nhau nên sinh màu khác nhau"
