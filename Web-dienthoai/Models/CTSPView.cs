using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_dienthoai.Models
{
    public class CTSPView
    {
        QLDienThoaiEntities db = new QLDienThoaiEntities();
        public string MaCTSP { get; set; }
        public string MaSP { get; set; }

        public string TenSP { get; set; }

        public string HinhSP { get; set; }
        public string tengiamgia { get; set; }

        public int? DonGia { get; set; }

        public int? SoLuong { get; set; }

        public double ThanhTien { get; set; }
        public CTSPView(string MaCTSP, int? sl)
        {
            this.MaCTSP = MaCTSP;

            var CTSP = db.ChiTietSP.FirstOrDefault(s => s.MaCTSP == MaCTSP);
            var SP = db.SanPham.FirstOrDefault(s => s.MaSP == CTSP.MaSP);
            this.MaSP = SP.MaSP;
            this.TenSP = SP.TenSP;
            this.HinhSP = db.HinhSP.FirstOrDefault(s => s.MaSP == SP.MaSP).MaHinh;
            this.DonGia = CTSP.Gia;
            this.SoLuong = sl ;
            var giamgiasp = db.GiamGiaSP.FirstOrDefault(s => s.MaSP == MaSP);
          
            if (giamgiasp == null)
            {
                this.ThanhTien = Convert.ToDouble( this.SoLuong * this.DonGia);
                this.tengiamgia = "";
            }
            else
            {
                  var magg = giamgiasp.MaGG;
                var chietkhau = (double)db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == magg).chietkhau;
                this.ThanhTien = Convert.ToDouble(this.SoLuong * this.DonGia-(this.SoLuong * this.DonGia*chietkhau));
                this.tengiamgia = db.PhieuGiamGia.FirstOrDefault(s => s.MaGG == magg).TenGiamGia;
            }
        }
    }
}