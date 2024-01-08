using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class ThongkeController : Controller
    {
        private QLDienThoaiEntities db = new QLDienThoaiEntities();
        // GET: Thongke
        public ActionResult Index()
        {
            List<DonHang> listDH = db.DonHang.ToList();
            double tongdt = (double)listDH.Sum(d=>d.TongTien);
            List<KhachHang> listKH = db.KhachHang.ToList();
            int SLkh = listKH.Count();
            int SLDH = listDH.Count();
            List<SanPham> lisSP = db.SanPham.ToList();
            double SLSP = (double)lisSP.Count();
            ViewBag.slSP = SLSP;
            ViewBag.sldh = SLDH;
            ViewBag.dt = tongdt;
            ViewBag.slkh = SLkh;
            return View();
        }
    }
}