using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_dienthoai.Models
{
    public class MatHangMua
    {
        QLDienThoaiEntities db = new QLDienThoaiEntities();

        public string MaSP { get; set; }

        public string TenSP { get; set; }

        public string HinhSP { get; set; }

        public double DonGia { get; set; }
        public double chietkhau { get; set; }
        public string tengiamgia { get; set; }
        public int SoLuong { get; set; }
        public string MaCTSP { get; set; }


        public double ThanhTien()
        {
            return SoLuong * DonGia-(SoLuong * DonGia*chietkhau);
        }

        public MatHangMua(string MaSP)
        {
            this.MaSP = MaSP;
            var phone = db.SanPham.Single(s => s.MaSP == this.MaSP);
            var pic = db.SanPham.FirstOrDefault(s => s.MaSP == this.MaSP);
            var detail = db.ChiTietSP.FirstOrDefault(s => s.MaSP == this.MaSP);
            this.TenSP = phone.TenSP;
            this.HinhSP = db.HinhSP.FirstOrDefault(s => s.MaSP == this.MaSP).MaHinh;
            this.DonGia = double.Parse(detail.Gia.ToString());
            this.SoLuong = 1;
            this.MaCTSP =db.ChiTietSP.FirstOrDefault(s => s.MaSP == this.MaSP).MaCTSP;
            
            var giamgia = db.GiamGiaSP.FirstOrDefault(s => s.MaSP == MaSP);
          
            if (giamgia == null)
            {
                this.chietkhau = 0;
                this.tengiamgia ="";
            }
            else
            {
                var magg = giamgia.MaGG;
                this.chietkhau = (double)db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == magg).chietkhau;
                this.tengiamgia= db.PhieuGiamGia.FirstOrDefault(s => s.MaGG ==magg).TenGiamGia;
            }
        }
    }
}