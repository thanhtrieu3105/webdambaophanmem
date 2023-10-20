using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_dienthoai.Models
{
    public class ChiTietDonHangView
    {
        public DonHang donHang { get; set; }

        public List<CTSPView> ListCTSPViews { get; set; }

        public ChiTietDonHangView(List<CTSPView> list, DonHang dh)
        {
            this.ListCTSPViews = list;
            this.donHang = dh;
        }
    }
}