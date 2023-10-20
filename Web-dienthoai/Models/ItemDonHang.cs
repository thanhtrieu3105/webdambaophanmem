using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_dienthoai.Models;

namespace Web_dienthoai.Models
{
    public class ItemDonHang
    {
        QLDienThoaiEntities db = new QLDienThoaiEntities();
        public string MaDH { get; set; }
        public string MaCTDH { get; set; }
        public string TenSP { get; set; }
        public string tengiamgia { get; set; }
        public int? SoLuong { get; set; }
        public string TongSo { get; set; }
        public int? gia { get; set; }
        public string TongSL { get; set; }
        public int? TongTien { get; set; }
        public string HinhSP { get; set; }
        public string Tinhtrang { get; set; }


        public String TongSoSP()
        {
            int? sl;
            List<ChiTietDH> listctdh = db.ChiTietDH.Where(s => s.MaDH == MaDH).ToList();
            sl = listctdh.Sum(s => s.SoLuong);
            return sl.ToString();
        }
        public SanPham sanpham()
        {
            var mactsp = db.ChiTietDH.FirstOrDefault(s => s.MaCTDH == MaCTDH).MaCTSP;
            var dbsp = db.ChiTietSP.FirstOrDefault(s => s.MaCTSP == mactsp).MaSP;
            SanPham sp = db.SanPham.FirstOrDefault(s => s.MaSP == dbsp);
            return sp;
        }
        public string hinhsp()
        {
            var masp = sanpham().MaSP;
            string hinh = db.HinhSP.FirstOrDefault(s => s.MaSP == masp).MaHinh;
            return hinh;
        }
        public int? Gia(string masp)
        {
            return db.ChiTietSP.FirstOrDefault(s => s.MaSP == masp).Gia;
        }

        public ItemDonHang(string MaDH, string mactdh)
        {
            this.MaDH = MaDH;
            this.MaCTDH = mactdh;
            this.TenSP = sanpham().TenSP;
            var ct = db.ChiTietDH.FirstOrDefault(s => s.MaDH == this.MaDH && s.MaCTDH == this.MaCTDH);
            this.SoLuong = ct.SoLuong;
            this.gia = Gia(sanpham().MaSP);
            this.TongSL = TongSoSP();
            var tt = db.DonHang.FirstOrDefault(s => s.MaDH == this.MaDH);
            this.TongTien = tt.TongTien;
            this.HinhSP = hinhsp();
            this.Tinhtrang = tt.TinhTrang;
            var masp = sanpham().MaSP;
            var giamgiasp = db.GiamGiaSP.FirstOrDefault(s => s.MaSP == masp);
            if (giamgiasp == null)
            {
                this.tengiamgia = " ";
            }
            else
            {

                var magg = giamgiasp.MaGG;
                this.tengiamgia = db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == magg).TenGiamGia;
            }

        }

    }
}