/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.32
 * Generated at: 2018-08-26 17:01:15 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.views.notice;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class noticeList_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("/views/notice/../../memberHeader.jsp", Long.valueOf(1534758020000L));
    _jspx_dependants.put("/views/notice/../../end.jsp", Long.valueOf(1533202554000L));
    _jspx_dependants.put("/views/notice/../../footer.jsp", Long.valueOf(1533706592000L));
    _jspx_dependants.put("/views/notice/../../head.jsp", Long.valueOf(1533891946000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />\r\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\" />\r\n");
      out.write("<meta name=\"format-detection\" content=\"telephone=no\" />\r\n");
      out.write("<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n");
      out.write("<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<link rel=\"stylesheet\" href=\"https://use.fontawesome.com/releases/v5.2.0/css/all.css\" integrity=\"sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ\" crossorigin=\"anonymous\">\r\n");
      out.write("<link rel=\"stylesheet\" href=\"/mimi/resources/css/bootstrap.css\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"/mimi/resources/js/jquery-3.3.1.min.js\"></script>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"/mimi/resources/css/admin-review-thema.css\">\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<!-- 바디 태그 시작 -->\r\n");
      out.write('\r');
      out.write('\n');
      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("<title>MIMI</title>\r\n");
      out.write("<!-- 상단에 노출되서 주석처리.. <title>memberHeader</title> -->\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\t\r\n");
      out.write("\tbody {\r\n");
      out.write("\t\tpadding-top: 120px;\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t.member-menu-box span, #mainNav > a { \r\n");
      out.write("\t\tdisplay: inline-block; \r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t/*메뉴 묶음 박스*/\r\n");
      out.write("\t#mini-menu-box{\r\n");
      out.write("\t\tposition:absolute;\r\n");
      out.write("\t\ttop:26px;\r\n");
      out.write("\t\tright: 100px;\r\n");
      out.write("\t\twidth:50px;\r\n");
      out.write("\t\theight:50px;\r\n");
      out.write("\t\t\r\n");
      out.write("\t}\r\n");
      out.write("/* \t\r\n");
      out.write("\t#mini-menu-box > div#menu-box-btn{\r\n");
      out.write("\t\tposition:absolute;\r\n");
      out.write("\t\tcolor: #666;\r\n");
      out.write("\t\ttop:-4px; \r\n");
      out.write("\t\tleft:0%;\r\n");
      out.write("\t\topacity:0.5;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t#menu-box-btn:hover {\r\n");
      out.write(" \t\topacity:1!important;\r\n");
      out.write(" \t\ttransition:all .6s linear;\r\n");
      out.write("\t} \r\n");
      out.write("*/\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t#mini-menu-box > div#menu-box-btn{\r\n");
      out.write("\t\tposition:absolute;\r\n");
      out.write("\t\ttop:-4px; \r\n");
      out.write("\t\tleft:0%;\r\n");
      out.write("\t\topacity:1;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t#menu-box-btn:hover {\r\n");
      out.write("\t\t/* background:#000000; */\r\n");
      out.write("  \t\t/* 추가된 부분 */\r\n");
      out.write(" \t\topacity:0.6!important;\r\n");
      out.write(" \t\ttransition:all .2s linear;\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t/*회원 메뉴 박스*/\r\n");
      out.write("\t.member-menu-box \r\n");
      out.write("\t{\r\n");
      out.write("\t\tdisplay : none;\r\n");
      out.write("\t\ttop: 58pt;\r\n");
      out.write("\t\tright:-29pt;\r\n");
      out.write("\t\tposition: absolute;\r\n");
      out.write("\t\twidth: 260px;\r\n");
      out.write("\t\theight: 350px;\r\n");
      out.write("\t\tpadding: 10px;\r\n");
      out.write("\t\tbackground: white;\r\n");
      out.write("\t\t-webkit-border-radius: 0px;\r\n");
      out.write("\t\t-moz-border-radius: 0px;\r\n");
      out.write("\t\tborder-radius: 0px;\r\n");
      out.write("\t\tborder: #000000 solid 1px;\r\n");
      out.write("\t\tbox-shadow:0 5px 20px rgba(0, 0, 0, 0.8);\r\n");
      out.write("\t}\r\n");
      out.write("\r\n");
      out.write("\t.member-menu-box:after \r\n");
      out.write("\t{\r\n");
      out.write("\t\tcontent: '';\r\n");
      out.write("\t\tposition: absolute;\r\n");
      out.write("\t\tborder-style: solid; \r\n");
      out.write("\t\tborder-width: 0 16px 20px;\r\n");
      out.write("\t\tborder-color: white transparent;\r\n");
      out.write("\t\tdisplay: block;\r\n");
      out.write("\t\twidth: 0;\r\n");
      out.write("\t\tz-index: 1;\r\n");
      out.write("\t\ttop: -20px;\r\n");
      out.write("\t\tleft: 185px;\r\n");
      out.write("\t} \r\n");
      out.write("\r\n");
      out.write("\t.member-menu-box:before \r\n");
      out.write("\t{\r\n");
      out.write("\t\tcontent: '';\r\n");
      out.write("\t\tposition: absolute;\r\n");
      out.write("\t\tborder-style: solid;\r\n");
      out.write("\t\tborder-width: 0 16px 20px;\r\n");
      out.write("\t\tborder-color: #000000 transparent;\r\n");
      out.write("\t\tdisplay: block;\r\n");
      out.write("\t\twidth: 0;\r\n");
      out.write("\t\tz-index: 0;\r\n");
      out.write("\t\ttop: -21px;\r\n");
      out.write("\t\tleft: 185px;\r\n");
      out.write("\t\t \r\n");
      out.write("\t}\r\n");
      out.write("\t@media (max-width:390px){\r\n");
      out.write("\t\t#mini-menu-box{\r\n");
      out.write("\t\t\t/* display:relative; */\r\n");
      out.write("\t\t\tleft : 200px!important\r\n");
      out.write("\t\t}\r\n");
      out.write("\t} \r\n");
      out.write("\t@media (max-width:355px){\r\n");
      out.write("\t\t#song-navbar-toggle{\r\n");
      out.write("\t\t\tleft:90px;\r\n");
      out.write("\t\t\twidth:75px;\r\n");
      out.write("\t\t}\t\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t@media (max-width: 992px){\r\n");
      out.write("\t\t.mini-li-box{\r\n");
      out.write("\t\t\tdisplay: inline-block;\r\n");
      out.write("\t\t\tfloat: none;\r\n");
      out.write("\t\t} \r\n");
      out.write("\t\t#bs-example-navbar-collapse-1{ /*헤더 네비 가운데 정렬*/\r\n");
      out.write("\t\t\ttext-align: center; \r\n");
      out.write("\t\t\r\n");
      out.write("\t\t} \r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t.mini-li-box{\r\n");
      out.write("\t\tdisplay: inline-block;\r\n");
      out.write("\t\tfloat: none;\r\n");
      out.write("\t} \r\n");
      out.write("\t#bs-example-navbar-collapse-1{ /*헤더 네비 가운데 정렬*/\r\n");
      out.write("\t\ttext-align: center; \r\n");
      out.write("\t\t\r\n");
      out.write("\t} \r\n");
      out.write("\t\r\n");
      out.write("\t@media (min-width: 993px){ \r\n");
      out.write("\t\t#bs-example-navbar-collapse-1{\r\n");
      out.write("\t\t\ttop:0px;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("\t<!-- Navigation -->\r\n");
      out.write("    <nav id=\"mainNav\" class=\"navbar navbar-default navbar-fixed-top header-and-footer\">\r\n");
      out.write("    \t\r\n");
      out.write("        <a href=\"/mimi/index.jsp\"><img style=\"position: absolute; max-height:50px;max-width:200px; left:5%; top:24px; z-index: 1;\" src=\"/mimi/resources/images/logo/mm_logo_onlytext_red.svg\"></a>\r\n");
      out.write("        <div class=\"container\" style=\"position:relative; top:-10px;\">\r\n");
      out.write("            <!-- Brand and toggle get grouped for better mobile display -->\r\n");
      out.write("            \r\n");
      out.write("            <div class=\"navbar-header\">\t\r\n");
      out.write("            \t\r\n");
      out.write("                <button id=\"song-navbar-toggle\" type=\"button\"  class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\">\r\n");
      out.write("                    <span class=\"sr-only\">Toggle navigation</span> Menu <i class=\"fa fa-bars\"></i>\r\n");
      out.write("                </button>\r\n");
      out.write("                \r\n");
      out.write("                <div style=\"height:50px;width:0px;\"></div><!--세로 크기 줄어들지 않게 하기 위한 투명 박스 -->\r\n");
      out.write("            </div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("            <!-- Collect the nav links, forms, and other content for toggling -->\r\n");
      out.write("            <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\" >\r\n");
      out.write("                <ul class=\"nav navbar-nav mini-li-box\">\r\n");
      out.write("                    <li class=\"hidden\">\r\n");
      out.write("                        <a href=\"#page-top\"></a>\r\n");
      out.write("                    </li> \r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/notice/noticeList.jsp\">공지사항</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/board/adminReview.jsp\">MIMI 리뷰</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/bestReview/bestReviewList.jsp\">Best리뷰</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/userReview/userReviewList.jsp\">유저리뷰</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/board/nearShop.jsp\">주변매장</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/supportlist\">고객센터</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                    <li>\r\n");
      out.write("                        <a href=\"/mimi/views/intro/information.jsp\">사이트소개</a>\r\n");
      out.write("                    </li>\r\n");
      out.write("                </ul>\r\n");
      out.write("            </div>\r\n");
      out.write("            <!-- /.navbar-collapse -->\r\n");
      out.write("        </div>\r\n");
      out.write("        <!-- /.container-fluid -->\r\n");
      out.write("        <nav id=\"mini-menu-box\">\r\n");
      out.write("\t\t\t<!-- <div id=\"menu-box-btn\" class=\"fas fa-user-circle\" aria-hidden=\"true\"></div> -->\r\n");
      out.write("\t\t\t<div id=\"menu-box-btn\"  aria-hidden=\"true\"><img src=\"/mimi/resources/images/icon/icon_level1.png\" width=\"60px\" ></img></div>\r\n");
      out.write("\t\t\t<!-- 회원 로그인 상태에서 메뉴 버튼 누를시 -->\r\n");
      out.write("\t\t\t<div class=\"member-menu-box\">\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<p align=\"center\" style=\"margin:0px;font-size:7pt;\">level1</p>\r\n");
      out.write("\t\t\t\t\t<p align=\"center\" style=\"margin:0px;\">Nickname</p>\r\n");
      out.write("\t\t\t\t\t<p align=\"center\" style=\"font-size:7pt;\">userID</p>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div align=\"center\">\r\n");
      out.write("\t\t\t\t\t<a href=\"#\">로그아웃</a>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<hr style=\"border: thin 1px black;\">\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t<div style=\"padding-top:20px;\" align=\"center\">\t\r\n");
      out.write("\t\t\t\t\t<span style=\"width:100px;\">\t\r\n");
      out.write("\t\t\t\t\t\t<a href=\"/mimi/views/board/myContent.jsp\">\r\n");
      out.write("\t\t\t\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p style=\"font-size:25pt;\" class=\"far fa-file-alt\" aria-hidden=\"true\"></p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p>작성한 글</p>\t\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t</span>\t\t\t\r\n");
      out.write("\t\t\t\t\t<span style=\"width:100px;\">\t\r\n");
      out.write("\t\t\t\t\t\t<a href=\"/mimi/views/board/myComment.jsp\">\r\n");
      out.write("\t\t\t\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p style=\"font-size:25pt;\" class=\"far fa-comments\" aria-hidden=\"true\"></p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p>작성한 댓글</p>\t\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\t<div style=\"padding-top:20px;\" align=\"center\">\t\r\n");
      out.write("\t\t\t\t\t<span style=\"width:100px;\">\r\n");
      out.write("\t\t\t\t\t\t<a href=\"/mimi/views/board/favoriteList.jsp\">\r\n");
      out.write("\t\t\t\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p style=\"font-size:25pt;\" class=\"fas fa-map-marker-alt\" aria-hidden=\"true\"></p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p>즐겨찾기</p>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t\t<span style=\"width:100px;\">\t\r\n");
      out.write("\t\t\t\t\t\t<a href=\"/mimi/views/member/passwordConfirmView.jsp\">\r\n");
      out.write("\t\t\t\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p style=\"font-size:25pt;\" class=\"fas fa-user\" aria-hidden=\"true\"></p>\r\n");
      out.write("\t\t\t\t\t\t\t\t<p>내 정보</p>\r\n");
      out.write("\t\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t</span>\r\n");
      out.write("\t\t\t\t</div>  \r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</nav>\r\n");
      out.write("    </nav>\r\n");
      out.write("    \r\n");
      out.write("    <script type=\"text/javascript\">\r\n");
      out.write("\t\t$(function(){\r\n");
      out.write("\t\t\t$(document).on(\"mouseover\", \"#menu-box-btn\", function(){\r\n");
      out.write("\t\t\t\t$(\"#menu-box-btn\").css(\"cursor\", \"pointer\");\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\t$(document).on(\"click\", \"#menu-box-btn\", function(){\r\n");
      out.write("\t\t\t\tif($(\".member-menu-box\").css(\"display\") === \"none\"){\r\n");
      out.write("\t\t\t\t\t$(\".member-menu-box\").slideDown(\"slow\", function() {\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\telse{\r\n");
      out.write("\t\t\t\t\t$(\".member-menu-box\").slideUp(\"slow\", function() {\n");
      out.write("\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\t\t\r\n");
      out.write("\t\t});\r\n");
      out.write("\t</script>\t\r\n");
      out.write("\r\n");
      out.write("</html>");
      out.write('\r');
      out.write('\n');
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<div class=\"container\" style=\"width:1150px;\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- 이미지 슬라이드 -->\r\n");
      out.write("<div class=\"carousel slide\" id=\"myCarousel\" data-ride=\"carousel\" style=\"padding: 5px 10px;\">\r\n");
      out.write("\t<!-- 하단 리스트 -->\r\n");
      out.write("\t<ol class=\"carousel-indicators\">\r\n");
      out.write("\t\t<li data-target=\"#myCarousel\" data-slide-to=\"0\" class=\"active\"></li>\r\n");
      out.write("\t\t<li data-target=\"#myCarousel\" data-slide-to=\"1\"></li>\r\n");
      out.write("\t\t<li data-target=\"#myCarousel\" data-slide-to=\"2\"></li>\r\n");
      out.write("\t\t<li data-target=\"#myCarousel\" data-slide-to=\"3\"></li>\r\n");
      out.write("\t\t<li data-target=\"#myCarousel\" data-slide-to=\"4\"></li>\r\n");
      out.write("\t</ol>\r\n");
      out.write("\r\n");
      out.write("\t<div class=\"carousel-inner\">\r\n");
      out.write("\t\t<div class=\"item active\">\r\n");
      out.write("\t\t<div class=\"img-div2\">\r\n");
      out.write("\t\t\t<a href=\"#\"><img src=\"/mimi/resources/images/main/img3.jpg\" class=\"img2\" alt=\"\"></a></div>\r\n");
      out.write("\t\t\t<div class=\"container carousel-caption\">\r\n");
      out.write("\t\t\t\t</div> \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"item\">\r\n");
      out.write("\t\t<div class=\"img-div2\">\r\n");
      out.write("\t\t\t<a href=\"#\"><img src=\"/mimi/resources/images/main/img1.jpg\" class=\"img2\" alt=\"\"></a></div>\r\n");
      out.write("\t\t\t<div class=\"container carousel-caption\">\r\n");
      out.write("\t\t\t\t</div> \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"item\">\r\n");
      out.write("\t\t<div class=\"img-div2\">\r\n");
      out.write("\t\t\t<a href=\"#\"><img src=\"/mimi/resources/images/main/img4.jpg\" class=\"img2\" alt=\"\"></a></div>\r\n");
      out.write("\t\t\t<div class=\"container carousel-caption\">\r\n");
      out.write("\t\t\t\t</div> \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"item\">\r\n");
      out.write("\t\t<div class=\"img-div2\">\r\n");
      out.write("\t\t\t<a href=\"#\"><img src=\"/mimi/resources/images/main/img6.jpg\" class=\"img2\" alt=\"\"></a></div>\r\n");
      out.write("\t\t\t<div class=\"container carousel-caption\">\r\n");
      out.write("\t\t\t\t</div> \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"item\">\r\n");
      out.write("\t\t<div class=\"img-div2\">\r\n");
      out.write("\t\t\t<a href=\"#\"><img src=\"/mimi/resources/images/main/img2.jpg\" class=\"img2\" alt=\"\"></a></div>\r\n");
      out.write("\t\t\t<div class=\"container carousel-caption\">\r\n");
      out.write("\t\t\t\t</div> \r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("\r\n");
      out.write("<!-- /이미지 슬라이드 -->\r\n");
      out.write("\r\n");
      out.write("\t<table style=\"width:100%; border:0;\">\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td><h3>공지사항</h3></td>\r\n");
      out.write("\t\t\t<td style=\"text-align: right; vertical-align:bottom; color:#777\">\r\n");
      out.write("\t\t\t\t<!-- 카테고리 -->\r\n");
      out.write("\t\t\t\t<form class=\"form-inline\" name=\"select-category\" id=\"select-category\" method=\"get\" action=\"#\">\r\n");
      out.write("\t\t\t\t\t<div class=\"form-group\" style=\"float: right; margin:3px;\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"text\" class=\"form-control\" name=\"search-text\" id=\"search-text\" size=\"12\" placeholder=\" \">\r\n");
      out.write("\t\t\t\t​​​​​​​  \t\t<button type=\"button\" class=\"btn\" name=\"btn\" style=\"outline: none\">검색&nbsp;<i class=\"fas fa-search\"></i>\r\n");
      out.write("\t\t\t</button>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</form>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("<!-- 게시글 -->\r\n");
      out.write("<hr class=\"margin2\">\r\n");
      out.write("<table class=\"table table-hover\" id=\"table-css\">\r\n");
      out.write("\t<thead>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<th width=\"12%\">글번호</th><th width=\"30%\">제목</th><th width=\"16%\"><i class=\"fas fa-pen\"></i>작성자</th><th width=\"16%\"><i class=\"far fa-calendar\"></i>작성일</th>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t</thead>\r\n");
      out.write("\t<tbody>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td>100<!-- 글번호 --></td>\r\n");
      out.write("\t\t<td class=\"tbl-td-title\"><a href=\"noticeView.jsp\">Title</a><!-- 제목 --></td>\r\n");
      out.write("\t\t<td>Nickname<!-- 작성자 --></td>\r\n");
      out.write("\t\t<td>2018-07-30<!-- 작성일 --></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t</tbody>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- /게시글 -->\r\n");
      out.write("<hr class=\"margin1\" style=\"margin: 0px auto 5px auto;\">\r\n");
      out.write("\r\n");
      out.write("<table style=\"width:100%\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td width=\"10%\"></td><!-- 빈칸 -->\r\n");
      out.write("\t\t<td width=\"*\"><!-- 페이지 -->\r\n");
      out.write("\t<!-- Pagination -->\r\n");
      out.write("\t\t<ul class=\"pagination\" style=\"float: center; display: flex; justify-content: center;\">\r\n");
      out.write("\t\t\t<li>\r\n");
      out.write("\t\t\t\t<a href=\"#\" aria-label=\"Previous\">\r\n");
      out.write("\t\t\t\t<span aria-hidden=\"true\">&laquo;</span>\r\n");
      out.write("\t\t\t\t<span class=\"sr-only\">Previous</span>\r\n");
      out.write("\t\t\t\t</a>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li>\r\n");
      out.write("\t\t\t\t<a href=\"#\">1</a>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li>\r\n");
      out.write("\t\t\t\t<a href=\"#\">2</a>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li>\r\n");
      out.write("\t\t\t\t<a href=\"#\">3</a>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li>\r\n");
      out.write("\t\t\t\t<a href=\"#\" aria-label=\"Next\">\r\n");
      out.write("\t\t\t\t<span aria-hidden=\"true\">&raquo;</span>\r\n");
      out.write("\t\t\t\t<span class=\"sr-only\">Next</span>\r\n");
      out.write("\t\t\t\t</a>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t</ul>\t\r\n");
      out.write("\t</td>\r\n");
      out.write("\t\t<!-- 글쓰기버튼 -->\r\n");
      out.write("\t\t<td width=\"10%\" style=\"vertical-align:top;\">\r\n");
      out.write("\t\t\t\t\t\t<input type=\"button\" class=\"btn btn-default pull-right\"\r\n");
      out.write("\t\t\tonClick=\"location.href='/mimi/views/notice/noticeWrite.jsp'\"\r\n");
      out.write("\t\t\tvalue=\"글쓰기\" style=\"outline: none;\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</div><!-- /container -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- <title>Insert title here</title> -->\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t.header-and-footer{\r\n");
      out.write("\t\tpadding-top: 15px;\r\n");
      out.write("\t\tpadding-bottom: 15px; \r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t.custom-footer{\r\n");
      out.write("\tmin-width:1150px; /* 추가, 게시판 너비 맞춤*/\r\n");
      out.write("\t\tmargin-top: 50px;\r\n");
      out.write("\t\tmargin-bottom: 0px;\r\n");
      out.write("\t}\r\n");
      out.write("\t.footer{\r\n");
      out.write("\t\t\r\n");
      out.write("\t\ttext-align:center;\r\n");
      out.write("\t\tmargin-top: 2px;\r\n");
      out.write("\t\tmargin-bottom: 2px;\r\n");
      out.write("\t\r\n");
      out.write("\t}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("\t<nav class=\"navbar navbar-default custom-footer header-and-footer\">\r\n");
      out.write("  \t\t<div class=\"container\">\r\n");
      out.write("   \t\t\t<p class=\"footer\">이용약관 개인정보처리방침 책임의 한계와 법적고지 고객센터</p>\r\n");
      out.write("   \t\t\t<p class=\"footer\">tel : 010-0000-0000 fax: 000-0000-0000</p>\r\n");
      out.write("   \t\t\t<p class=\"footer\">Copyright MIMI Corp.All Rights Reserved.</p>\r\n");
      out.write("  \t\t</div>\r\n");
      out.write("\t</nav>");
      out.write(" \t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"/mimi/resources/js/bootstrap.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"/mimi/resources/js/kakao.min.js\"></script>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("</body>\r\n");
      out.write("<!-- 바디 태그 끝 -->\r\n");
      out.write("</html>\t");
      out.write(' ');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
