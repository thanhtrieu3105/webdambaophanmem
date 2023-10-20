using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_dienthoai.Models;

namespace Web_dienthoai.Controllers
{
    public class AdminController : Controller
    {
        QLDienThoaiEntities database = new QLDienThoaiEntities();
        // GET: Default
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Admin admin)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(admin.TKAdmin))
                    ModelState.AddModelError(string.Empty, "Vui lòng điền tên đăng nhập");
                if (string.IsNullOrEmpty(admin.MKAdmin))
                    ModelState.AddModelError(string.Empty, "Vui lòng điền mật khẩu");

                if (ModelState.IsValid)
                {
                    //Tìm KH hợp lệ có trong CSDL
                    var ad = database.Admin.FirstOrDefault(id => id.TKAdmin == admin.TKAdmin && admin.MKAdmin == id.MKAdmin);
                    if (admin != null)
                    {
                        ViewBag.ThongBao = "Đăng nhập thành công!";
                        //Lưu > session
                        Session["Admin"] = ad;
                        return RedirectToAction("Index", "QuanLySanPham");
                    }
                    else
                        ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không hợp lệ !";
                }
            }
            return View();

        }
    }
}