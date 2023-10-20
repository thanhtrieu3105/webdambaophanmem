using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_dienthoai.Models
{
    public class DetailsView
    {
        public SanPham SanPham { get; set; }

        public List<HinhSP> HinhSP { get; set; }

        public ChiTietSP ChiTietSP { get; set; }

        public DungLuong DungLuong { get; set; }

        public TSKTSP TSKTSP { get; set; }
        public String Anh { get; set; }

        public ThuongHieu ThuongHieu { get; set; }
        public List<BinhLuan>  BinhLuan { get; set; }

    }
}