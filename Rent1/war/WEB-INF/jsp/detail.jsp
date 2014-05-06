<%@page import="com.rent1.entity.RentalProduct"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>

<head>
<%
	RentalProduct prod = (RentalProduct) session
			.getAttribute("showProduct");
%>
<meta charset="utf-8">
<title><%=prod.getWebTitle()%> | RENT1</title>
<meta name="robots" content="follow, index" />
<meta content="<%=prod.getWebTitle()%>"
	about="/details/<%=prod.getId()%>/<%=prod.getWebPage()%>"
	property="dc:title" />
<meta name="description"
	content="Rent a <%=prod.getWebTitle()%> for your project. Lowest Rate Guarantee on all longer term rentals" />
<meta name="keywords"
	content="rent a <%=prod.getCategory()%>, <%=prod.getCategory()%> rental rates,  <%=prod.getMake()%> rentals, <%=prod.getModelName()%> rentals, rentals, construction equipment," />

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<!-- START Tab Content -->
<link rel="stylesheet" href="/webincludes/css/tabcontent3.css">
<script src="/webincludes/js/tabcontent.js"></script>
<!-- END Tab Content -->
<!-- javascript load bootstrap elements =============== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ================================================== -->
<script src="/webincludes/js/rent1.js"></script>
<link rel="icon" type="image/png" href="/favicon.ico">
</head>
<body>
	<%@include file='/WEB-INF/jsp/header.jsp'%>

	<section id="section-content" class="section section-content">
		<div class="content" style="background: #D8D8D8">
			<div class="jumbotron home bg-img"></div>
			<div class="det_container box_outset ">
				<div class="row search-horizontal">
					<div class="span12">
						<div class="row">
							<aside class="span3" style="background: #f2f2f2; color: black;">
								<section style="background: #f2f2f2;">
									<div class="block-inner clearfix">
										<h4 class="ul_dashed">RENT1 is open 24/7</h4>
										<div class="clearfix">
											<p style="text-align: center;">
												<img alt="" src="/webincludes/img/open-7-days.png"
													style="width: 192px; height: 171px;" />
											</p>
											<p style="text-align: center;">We're open Saturdays and
												Sundays, no matter when you need your rental.</p>
										</div>
									</div>
								</section>
								<section>
									<div class="block-inner clearfix">
										<h4 class="ul_dashed">Support RENT1</h4>
										<div class="clearfix">
											<p style="text-align: center;">
												(Scrolling ad window below) <img alt=""
													src="https://secure.eyereturn.com/16044/w14-0373_on_demand_300x250_anchorman_2_sv8_v1.jpg" />
											</p>
										</div>
									</div>
								</section>
							</aside>
							<div class="span9" style="background: White">
								<h2 class="title_green"><%=prod.getWebTitle()%></h2>
								<aside class="span4">
									<img alt=""
										src="/webincludes/img/brand/jdeere/320d-ss_1_fs.jpg"
										style="height: 214px; width: 310px; z-index: 9999;"
										id="imgClickAndChange" />
									<div id="gallery-thumbs">
										<img class="img_border"
											src="/webincludes/img/brand/jdeere/320d-ss_1.jpg"
											style="height: 75; width: 75; cursor: pointer;"
											alt="<%=prod.getWebTitle()%>"
											onclick="changeImage('imgClickAndChange','/webincludes/img/brand/jdeere/320d-ss_1_fs.jpg')" />
										<img class="img_border"
											src="/webincludes/img/brand/jdeere/320d-ss_2.jpg"
											style="height: 75; width: 75; cursor: pointer;"
											alt="<%=prod.getWebTitle()%>"
											onclick="changeImage('imgClickAndChange', '/webincludes/img/brand/jdeere/320d-ss_2_fs.jpg')" />
									</div>
								</aside>
								<div class="span4 price_box">
									<div id="pricing" class="det_table_price">
										<table class="det_table_price">
											<tr>
												<th></th>
												<th>Daily</th>
												<th>Weekly</th>
												<th>Monthly</th>
											</tr>
											<tr>
												<th>Rates</th>
												<td><%=prod.getPricePlan().getCurrencySymbol()
					+ prod.getPricePlan().getRateDaily()%></td>
												<td><%=prod.getPricePlan().getCurrencySymbol()
					+ prod.getPricePlan().getRateWeekly()%></td>
												<td><%=prod.getPricePlan().getCurrencySymbol()
					+ prod.getPricePlan().getRateMonthly()%></td>
											</tr>
											<tr>
												<td colspan="4">
													<div class="delivery">
														+ Delivery Rate
														<div style="float: right;">
															<a href="/rent-now?prodId=<%=prod.getId()%>" class="btn btn-primary btn-small">Rent
																Now</a>
														</div>
													</div>
												</td>
											</tr>
										</table>
									</div>
									<div id="guarantee" class="honor" style="background: #f2f2f2;">
										<div style="float: left">
											<img src="/webincludes/img/rate-guarantee.png" />
										</div>
										<div>We honor the lowest rate on all long term rentals.</div>
									</div>
								</div>
								<div class="span9" style="margin: 1px; margin-top: 40px;">
									<ul class="tabs" data-persist="true">
										<li><a href="#tabDesc">Description</a></li>
										<li><a href="#tabSpec">Specifications</a></li>
									</ul>
									<div class="control-group tabcontents">
										<div id=tabDesc>
											<p>Need to rent a Skid Steer for a commercial or
												residential project that can carry more weight than a John
												Deere 318D skidsteer? If tight spaces are not an issue, then
												the increased power and load capacity of a John Deere 320D
												Skid Steer Rental might be the way to go.</p>
											<p>
												<b>Powerful:</b> The 320D Skid Steer's Turbocharged 2.4L
												diesel engine delivers 69 HP (vs. 61 for the John Deere 318D
												Skid Steer Rental), and allows you to carry loads of up to
												2000 lbs (vs. 1850 lbs. for the 318D). (And the 320D's
												Tipping Load is 4000 lbs. vs. 3,800 lbs. for the 318D.)
											</p>
										</div>
										<div id=tabSpec>
											<h3 class="title_green">Dimensions</h3>
											<table class="det_table_spec">
												<tbody>
													<tr>
														<td class="rb-Name">A. Length with Bucket</td>
														<td class="rb-Value" colspan="1">10.5 ft in</td>
														<td class="rb-Value">3195 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">B. Width Over Tires</td>
														<td class="rb-Value" colspan="1">5.8 ft in</td>
														<td class="rb-Value">1773 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">C. Height to Top of Cab</td>
														<td class="rb-Value" colspan="1">6.4 ft in</td>
														<td class="rb-Value">1951 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">D. Wheelbase</td>
														<td class="rb-Value" colspan="1">3.5 ft in</td>
														<td class="rb-Value">1074 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">E. Ground Clearance</td>
														<td class="rb-Value" colspan="1">9.6 in</td>
														<td class="rb-Value">244 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">F. Length w/o Bucket</td>
														<td class="rb-Value" colspan="1">8.5 ft in</td>
														<td class="rb-Value">2591 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">G. Clearance at Max Lift and Dump</td>
														<td class="rb-Value" colspan="1">7.5 ft in</td>
														<td class="rb-Value">2290 mm</td>
													</tr>
													<tr>
														<td class="rb-Name">H. Reach at Max Lift and Dump</td>
														<td class="rb-Value" colspan="1">28.1 in</td>
														<td class="rb-Value">714 mm</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>