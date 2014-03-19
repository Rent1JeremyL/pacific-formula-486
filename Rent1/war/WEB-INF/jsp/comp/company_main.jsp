<%@page import="com.rent1.dao.ProductDao"%>
<%@page import="com.rent1.entity.DefaultProduct"%>
<%@page import="com.rent1.dao.OfficeDao"%>
<%@page import="com.rent1.entity.Company"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.rent1.entity.Office"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Company Profile</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<!-- START Tab Content -->
<link rel="stylesheet" href="/webincludes/css/tabcontent.css">
<script src="/webincludes/js/tabcontent.js"></script>
<!-- END Tab Content -->

<link rel="icon" type="image/png" href="/favicon.ico">
<!-- javascript load bootstrap elements =============== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ================================================== -->
<script src="/webincludes/js/rent1.js"></script>
</head>
<script type='text/javascript'>
	jQuery(function($) {
		$('a[data-confirm], input[data-confirm]').live('click', function() {
			if (!confirm($(this).attr('data-confirm'))) {
				return false;
			}
		});
	});
</script>
<body>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<%
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request,
			response);
			return;
		}
		Company comp = user.getCompany();
	%>
<!-- javascript create Category variables =============== -->
<script>
	var secArray = new Array();
	<%
	int i=1;
	for(Category cata : catagories){
		String secArray = CategoryFactory.getInstance().getSecondayCatagoriesToJS(cata);
	%>
		secArray[<%=i%>]="<%=secArray%>";
	<%
		i++;
	}
	%>
</script>	
	<div id="profile" style="background-color: #EEEEEE">
		<div class="section-title_h">
			<h3 id="h3-name">
				<%=comp.getName()%>
			</h3>
		</div>
		<br>
		<ul class="tabs" data-persist="true">
			<li><a href="#cTab1">Company Information</a></li>
			<li><a href="#cTab2">Office Information</a></li>
			<li><a href="#cTab3">Equipment</a></li>
			<li><a href="#view4">Orders</a></li>
			<li><a href="#view5">Members</a></li>
		</ul>
		<div class="control-group tabcontents profile_box_left">
			<%
				List<Office> offices = OfficeDao.INSTANCE.getOfficesByCompany(comp);
			%>
			<%@include file='/WEB-INF/jsp/comp/cmain_tab1.jsp'%>
			<%@include file='/WEB-INF/jsp/comp/cmain_tab2.jsp'%>
			<div id="cTab3">
				<div class="row">
					<aside class="span3">
						<section class="boxed-menu">
							<h3>Offices</h3>
							<div class="boxed-menu-inner">
								<ul class="boxed-group-list standalone">
									<%
										int linkID = 0;
										if (offices != null) {
										for (Office office : offices) {
											linkID++;
									%>
									<li><a href="#office-<%=linkID%>">Office <%=linkID%></a><br>
										&bull; <%=office.toShortString()%></li>
									<%
										}
																								}
									%>
								</ul>
							</div>
						</section>
					</aside>
					<div class="strong">
						<h5>Add rental equipment:</h5>
						<div id="addEquipment">
						<form class="form-horizontal" action="#" method="POST">
							<div class="custom-select-container">
								<select id="office" name="office" class="small">
									<%
										if (offices != null) {
										for (Office office : offices) {
									%>
									<option value="<%=office.getId()%>"><%=office.toShortString()%></option>
									<%
										}
																								}
									%>
								</select> <select id="category1" name="category1"
									class="small" onChange="populateSecCategory('category1', 'category2')">
									<option value="">Select Category</option>
									<%									
										for (Category cata : catagories) {
									%>
									<option value="<%=cata%>"><%=cata%></option>
									<%
										}
									%>
								</select> <select id="category2" name="category2"
									class="small">
									<option value="">Select Category</option>
								</select>
								<button id="showEquipAdd" type="submit" class="btn">
								Next</button>
							</div>
							</form>
						</div>
					</div>
					<div class="boxed-group">
						<h3>Equipment</h3>
						<div class="boxed-group-inner">
							<ul class="boxed-group-list standalone">
								<%
									linkID = 0;
									if (offices != null) {
										for (Office office : offices) {
											linkID++;
								%>
								<li><a id="office-<%=linkID%>" class="more"
									data-toggle="collapse" data-target="#table-<%=linkID%>"> <b>Office
											<%=linkID + ", " + office.toString()%> (7)
									</b></a>
									<div class="collapse" id="table-<%=linkID%>">
										<table class="table small">
											<tr>
												<td class="clearfix">John Deere <a
													class="btn btn-small minibutton"
													data-confirm="Are you POSITIVE you want to delete this item?"
													href="/delete/equipment?id=">Delete</a><a
													class="btn btn-small minibutton" href="/edit/equipment?id=">Edit</a>
												</td>
											</tr>
											<tr>
												<td class="clearfix">John Deere2 <a
													class="btn btn-small minibutton"
													data-confirm="Are you POSITIVE you want to delete this item?"
													href="/delete/equipment?id=">Delete</a>
												</td>
											</tr>
										</table>
									</div></li>
								<%
									}
									}
								%>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>