<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="com.rent1.entity.RentalProduct"%>
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
<link rel="stylesheet" href="/webincludes/css/tabcontent3.css">
<!-- END Tab Content -->
<link rel="icon" type="image/png" href="/favicon.ico">
<!-- ==== START [load bootstrap elements] ========== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ==== END ====================================== -->
<script src="/webincludes/js/rent1.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="/webincludes/js/html5shiv.js"></script>
<![endif]-->
</head>
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
	<div class="content" style="background: #D8D8D8;">
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div id="profile">
				<div class="section-title_h">
					<h3 class="title_green">
						<%=comp.getName()%>
					</h3>
				</div>
				<br>
				<%
					Map<Office, ArrayList<RentalProduct>> officeMap = (Map<Office, ArrayList<RentalProduct>>) request
							.getAttribute("showOffices");
					Set<Office> offices = officeMap.keySet();
				%>
				<ul class="tabs" data-persist="true">
					<li><a href="/company">Company Information</a></li>
					<li><a href="/company/offices">Office Information</a></li>
					<li><span class="tab_select">Equipment</span></li>
					<li><a href="/company/equipment/add">Add Equipment</a></li>
				</ul>
				<div class="control-group tabcontents">
					<%
						if (offices.size() != 0) {
					%>
					<div id="cTab3">
						<div class="row">
							<div class="span12">
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
								<div class="span8">
									<div class="boxed-group span8">
										<h3>Equipment</h3>
										<div class="boxed-group-inner">
											<ul class="boxed-group-list standalone">
												<%
													linkID = 0;
														if (offices != null) {
															for (Office office : offices) {
																ArrayList<RentalProduct> rps = officeMap.get(office);
																linkID++;
												%>
												<li><a id="office-<%=linkID%>" class="more"
													data-toggle="collapse" data-target="#table-<%=linkID%>">
														<b>Office <%=linkID + ", " + office.toString()%> (<%=rps.size()%>)
													</b>
												</a>
													<div class="collapse" id="table-<%=linkID%>">
														<form id="frm-add-prod" action="/company/update/product"
															method="post">
															<!--  div style="color: red;">${errCompany}</div -->
															<table class="det_table_spec">
																<%
																	for (RentalProduct rp : rps) {
																%>
																<tr>
																	<td class="clearfix"><%=rp.getWebTitle()%> <a
																		href="<%=rp.getCompanyHref()%>" target="_blank">(detail)</a>
																		<a class="btn btn-small minibutton"
																		onClick="return deletechecked('Are you POSITIVE you want to delete this item?')"
																		href="/company/equipment/delete?equipId=<%=rp.getId()%>">Delete</a>
																		<a class="btn btn-small minibutton"
																		onClick="toggle_visibility('update-<%=rp.getId()%>')">Edit</a>
																		<span id="update-<%=rp.getId()%>"
																		style="display: none;">
																			<table class="table_small">
																				<tr>
																					<th>Hourly</th>
																					<th>Daily</th>
																					<th>Weekly</th>
																					<th>Monthly</th>
																				</tr>
																				<tr>
																					<td><input id="upd-hourly-<%=rp.getId()%>"
																						name="upd-hourly-<%=rp.getId()%>" class="span1"
																						value="<%=rp.getPricePlan().getRateHourly()%>"
																						type="number" pattern="?[0-9]"></td>
																					<td><input id="upd-daily-<%=rp.getId()%>"
																						name="upd-daily-<%=rp.getId()%>" class="span1"
																						value="<%=rp.getPricePlan().getRateDaily()%>"
																						type="number" pattern="?[0-9]"></td>
																					<td><input id="upd-weekly-<%=rp.getId()%>"
																						name="upd-weekly-<%=rp.getId()%>" class="span1"
																						value="<%=rp.getPricePlan().getRateWeekly()%>"
																						type="number" pattern="?[0-9]"></td>
																					<td><input id="upd-monthly-<%=rp.getId()%>"
																						name="upd-monthly-<%=rp.getId()%>" class="span1"
																						value="<%=rp.getPricePlan().getRateMonthly()%>"
																						type="number" pattern="?[0-9]"></td>
																				</tr>
																				<tr>
																					<td colspan="4"><button id="submit-<%=rp.getId()%>"
																					name="submit-<%=rp.getId()%>"
																						class="label_input_left btn btn-small minibutton"
																						type="submit">Update</button></td>
																				</tr>
																			</table>
																	</span></td>
																</tr>
																<%
																	}
																%>
															</table>
														</form>
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
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>