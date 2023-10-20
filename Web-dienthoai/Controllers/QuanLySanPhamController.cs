using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;
using System.Net;
using System.IO;
using System.Data.Entity;
namespace Web_dienthoai.Controllers
{
    public class QuanLySanPhamController : Controller
    {
        QLDienThoaiEntities database = new QLDienThoaiEntities();
        // GET: Product
        public ActionResult Index()
        {
            var list = new List<ProductView>();

            var sanpham = database.SanPham.ToList();
            foreach (var item in sanpham)
            {
                var chitietSP = database.ChiTietSP.FirstOrDefault(id => id.MaSP == item.MaSP);
                var hinhSP = database.HinhSP.FirstOrDefault(id => id.MaSP == item.MaSP);
                var thuongHieu = database.ThuongHieu.Find(item.MaTH);
                var MyView = new ProductView()
                {
                    SanPham = item,
                    HinhSP = hinhSP,
                    ChiTietSP = chitietSP,
                    ThuongHieu = thuongHieu
                };
                list.Add(MyView);
            }
            return View(list);
        }

        public ActionResult Details(string id)
        {
            var tskt = database.TSKTSP.FirstOrDefault(s => s.MaSP == id);

            var sp = database.SanPham.FirstOrDefault(s => s.MaSP == id);
            var ct = database.ChiTietSP.FirstOrDefault(s => s.MaSP == id);
            var th = database.ThuongHieu.FirstOrDefault(s => s.MaTH == sp.MaTH);
            var lthinh = database.HinhSP.Where(s => s.MaSP == id).ToList();
            var dtv = new DetailsView()
            {
                SanPham = sp,
                TSKTSP = tskt,
                ChiTietSP = ct,
                HinhSP = lthinh,
                ThuongHieu = th
            };

            return View(dtv);
        }

        [HttpGet]
        public ActionResult Create()
        {
            var th = database.ThuongHieu.ToList();

            return View(th);
        }

        [HttpPost]
        public ActionResult Create(SanPham sp, ChiTietSP ctsp, TSKTSP tskt, HttpPostedFileBase Anh, string MaTH)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(sp.TenSP))
                    ModelState.AddModelError(string.Empty, " tên san pham không được để trống");
                if (Anh.FileName==null)
                    ModelState.AddModelError(string.Empty, " ảnh sản phẩm không được để trống");
                //Lấy tên file của hình được up lên kiem tra trung ten voi anh da co
                else
                {
                    var fileName1 = Path.GetFileName(Anh.FileName);
                    if (database.HinhSP.FirstOrDefault(s => s.MaHinh == fileName1)?.MaHinh != null)
                        ModelState.AddModelError(string.Empty, "Trùng tên hình với sản phẩm khác");
                }

                if (ModelState.IsValid)
                {

                    int mats = 1;

                    //tao ma thong so ky thuat
                    while (database.TSKTSP.FirstOrDefault(s => s.MaTS == mats)?.MaTS != null)
                    {
                        mats++;

                    }

                    ////san pham
                    sp.MaSP = TaoMa("sp");
                    sp.MaTH = MaTH;
                    database.SanPham.Add(sp);
                    ///thong so sp
                    tskt.MaSP = sp.MaSP;
                    tskt.MaTS = mats;
                    database.TSKTSP.Add(tskt);
                    ///chi tiet sp
                    ctsp.MaCTSP = TaoMa("ctsp");
                    ctsp.MaSP = sp.MaSP;
                    ctsp.MaDL = "DL01";
                    ctsp.MaMau = "M01";
                    database.ChiTietSP.Add(ctsp);
                    //hinh san pham
                    var hinhsp = new HinhSP();
                    if (Anh != null)
                    {
                        //Lấy tên file của hình
                        var fileName = Path.GetFileName(Anh.FileName);
                        //Tạo đường dẫn tới file

                        var path = Path.Combine(Server.MapPath("~/Images/Phones"), fileName);
                        //Lưu tên
                        hinhsp.MaHinh = fileName;
                        hinhsp.MaSP = sp.MaSP;
                        //Save vào Images Folder
                        Anh.SaveAs(path);
                    }
                    database.HinhSP.Add(hinhsp);
                    database.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            var th = database.ThuongHieu.ToList();
            return View(th);
        }

        [HttpGet]
        public ActionResult Edit(string id)
        {
            var sanpham = database.SanPham.FirstOrDefault(s => s.MaSP == id);
            var ct = database.ChiTietSP.FirstOrDefault(s => s.MaSP == id);
            var ts = database.TSKTSP.FirstOrDefault(s => s.MaSP == id);
            var pv = new ProductView()
            {

                SanPham = sanpham,
                ChiTietSP = ct,
                TSKTSP = ts,
            };
            var masp = pv.SanPham.MaSP;
            Session["editsp"] = masp;
            ViewBag.TH = database.ThuongHieu.ToList();
            ViewBag.THSP = database.ThuongHieu.FirstOrDefault(S => S.MaTH == sanpham.MaTH).TenTH;
            return View(pv);
        }

        [HttpPost]
        public ActionResult Edit(SanPham sp,ChiTietSP ct, TSKTSP ts)
        {
            
            string masp = Session["editsp"] as string;
            var sp1 = database.SanPham.FirstOrDefault(s => s.MaSP == masp);
            if (ModelState.IsValid)
            {

               
                var ctsp = database.ChiTietSP.FirstOrDefault(s => s.MaSP == sp.MaSP);
                var tskt = database.TSKTSP.FirstOrDefault(s => s.MaSP == sp.MaSP);
                sp1.TenSP = sp.TenSP;
                sp1.MoTaSP = sp.MoTaSP;
                sp1.MaTH = sp.MaTH;
                //ctsp.SoLuongKho = ct.SoLuongKho;
                ctsp.Gia = ct.Gia;
                tskt.CongNgheManHinh = ts.CongNgheManHinh;
                tskt.DoPhanGiai = ts.DoPhanGiai;
                tskt.ManHinhrong = ts.ManHinhrong;
                tskt.MatKinhCamUng = ts.MatKinhCamUng;
                tskt.DoPhanGiaiCamS = ts.DoPhanGiaiCamS;
                tskt.QuayPhim = ts.QuayPhim;
                tskt.Flash = ts.Flash;
                //tskt.TinhNangCamS = ts.TinhNangCamS;
                //tskt.DoPhanGiaiCamT = ts.DoPhanGiaiCamT;
                //tskt.TinhNangCamT = ts.TinhNangCamT;
                //tskt.HeDieuHanh = ts.HeDieuHanh;
                //tskt.CPU = ts.CPU;
                //tskt.TocDoCPU = ts.TocDoCPU;
                //tskt.GPU = ts.GPU;
                //tskt.RAM = ts.RAM;
                //tskt.DungLuong = ts.DungLuong;
                //tskt.DungLuongCon = ts.DungLuongCon;
                //tskt.DanhBa = ts.DanhBa;
                //tskt.Mang = ts.Mang;
                //tskt.Sim = ts.Sim;
                //tskt.Wifi = ts.Wifi;
                //tskt.GPS = ts.GPS;
                //tskt.Bluetooth = ts.Bluetooth;
                //tskt.Sac = ts.Sac;
                //tskt.Jack = ts.Jack;
                //tskt.KetNoiKhac = ts.KetNoiKhac;
                //tskt.DungLuongPin = ts.DungLuongPin;
                //tskt.LoaiPin = ts.LoaiPin;
                //tskt.SacToiDa = ts.SacToiDa;
                //tskt.CongNghePin = ts.CongNghePin;
                //tskt.BaoMatNC = ts.BaoMatNC;
                //tskt.TinhNangDB = ts.TinhNangDB;
                //tskt.KhangNuocBui = ts.KhangNuocBui;
                //tskt.XemPhim = ts.XemPhim;
                //tskt.NgheNhac = ts.NgheNhac;
                //tskt.ThietKe = ts.ThietKe;
                //tskt.ChatLieu = ts.ChatLieu;
                //tskt.KichThuoc = ts.KichThuoc;
                //tskt.ThoiDiemRaMat = ts.ThoiDiemRaMat;
                database.SaveChanges();

                Session["editsp"] = null;
                return RedirectToAction("Index");
            }
            var sanpham = database.SanPham.FirstOrDefault(s => s.MaSP == masp);
            var ctSP = database.ChiTietSP.FirstOrDefault(s => s.MaSP == masp);
            var tsKT = database.TSKTSP.FirstOrDefault(s => s.MaSP == masp);
            var pv = new ProductView()
            {

                SanPham = sanpham,
                ChiTietSP = ct,
                TSKTSP = ts,
            };
            ViewBag.THSP = database.ThuongHieu.FirstOrDefault(S => S.MaTH == sanpham.MaTH).TenTH;
            ViewBag.TH = new SelectList(database.ThuongHieu, "MaTH", "TenTH", sp1.MaTH);
            return View(sp1);
        }


        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var sanpham = database.SanPham.Where(c => c.MaSP == id).FirstOrDefault();
            if (sanpham == null)
            {
                return HttpNotFound();
            }

            return View(sanpham);
        }
        public ActionResult XoaSP(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var sanpham = database.SanPham.FirstOrDefault(c => c.MaSP == id);
            var ct = database.ChiTietSP.FirstOrDefault(s => s.MaSP == sanpham.MaSP);
            var dh = database.ChiTietDH.FirstOrDefault(s => s.MaCTSP == ct.MaCTSP);
            if (dh == null)
            {
                database.xoasp(sanpham.MaSP);
                database.SaveChanges();
                return RedirectToAction("Index");
            }

            return RedirectToAction("HoiXoa", new { id = id });
        }

        public ActionResult HoiXoa(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var sp = database.SanPham.FirstOrDefault(s => s.MaSP == id);
            var ct = database.ChiTietSP.FirstOrDefault(s => s.MaSP == sp.MaSP);
            var dh = database.ChiTietDH.FirstOrDefault(s => s.MaCTSP == ct.MaCTSP);
            if (dh != null) ViewBag.thongbao = "Không thể xóa sản phẩm đã được mua";
            return View(sp);
        }
        public string TaoMa(string bien)
        {
            int ma = 1000;

            if (bien == "sp")
            {
                string masp = ma.ToString();
                //kiem tra ton tai ma don hang
                while (database.SanPham.FirstOrDefault(s => s.MaSP == masp) != null)
                {
                    ma++;
                    masp = ma.ToString();
                }
                return masp;
            }

            if (bien == "ctsp")
            {
                ma = 1000000;
                string mactsp = ma.ToString();
                //kiem tra ton tai ma don hang
                while (database.ChiTietSP.FirstOrDefault(s => s.MaCTSP == mactsp) != null)
                {
                    ma++;
                    mactsp = ma.ToString();
                }
                return mactsp;
            }

            return null;
        }


    }
}
