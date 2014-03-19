<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<link rel="stylesheet" href="/webincludes/css/production-uri.css">
<link rel="stylesheet" href="/webincludes/css/lightboxes-uri.css">
</head>
<body>
	<script type="text/javascript" src="/webincludes/js/countries.js"></script>
	<div id="fb-root"></div>
	<div id="alt-content"></div>
	<div id="main" class="jumbotron masthead home">
		<div id="lightbox-outer" class="">
			<div id="lightbox" class="lightbox-signup" style="width: 390px;">
				<a id="lightbox-close"
					class="close btn btn-rounded btn-icon-only btn-dark"
					href="/company"><i class="icon icon-ex-white-outline"></i></a>
				<div id="lightbox-inner">
					<div class="lbcontainer">
						<div id="lightbox-header">
							<h2 class="title">Office Information</h2>
						</div>
						<form action="/register/add/office" method="POST">
							<div id="lightbox-content" style="max-height: 400px;">
								<div class="lightbox-content-block">
									<div id="signup-stage-signup" class="signup-stage">
										<div class="control-group">
											<div style="color: #FF0000;">${errorMessage}</div>
											<div>
												<p class="placeholder-text label_input_left">*Street 1:</p>
												<input id="add-street1"
													class="placeholder-text data_input_right"
													name="add-street1" type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-text label_input_left">Street 2:</p>
												<input id="add-street2"
													class="placeholder-text data_input_right"
													name="add-street2" type="text" style="width: 210px;">
											</div>
											<div>
												<p class="placeholder-text label_input_left">*City:</p>
												<input id="add-city"
													class="placeholder-text data_input_right" name="add-city"
													type="text" style="width: 210px;" required>
											</div>
											<div>
												<p class="placeholder-text label_input_left">*Zip/Post Code:</p>
												<!-- For patterns http://html5pattern.com/Postal_Codes 	 	 -->
												<input id="add-zip"
													class="placeholder-text data_input_right" name="add-zip"
													type="text" style="width: 210px;" 
													required>
											</div>
											<div>
												<p class="placeholder-text label_input_left">*Country:</p>
												<select id="country" name="country"
													class="placeholder-text data_input_right"
													style="width: 210px;"></select>
											</div>
											<div>
												<p class="placeholder-text label_input_left">*State/Province:</p>
												<select name="state" id="state"
													class="placeholder-text data_input_right"
													style="width: 210px;"></select>
											</div>
											<script>
												populateCountries("country",
														"state");
											</script>
											<div>
												<p class="placeholder-text label_input_left">Phone:</p>
												<input id="add-phone"
													class="placeholder-text data_input_right" name="add-phone"
													type="tel" style="width: 210px;" placeholder="000-000-0000">
											</div>
											<div>
												<p class="placeholder-text label_input_left">Fax:</p>
												<input id="add-fax"
													class="placeholder-text data_input_right" name="add-fax"
													type="text" style="width: 210px;"
													placeholder="000-000-0000">
											</div>
										</div>
										<div id="signup-user-type" class="btn-group"></div>
									</div>
								</div>
							</div>
							<div id="lightbox-footer">
								<button id="addOffice"
									class="btn btn-large btn-primary btn-fullwidth" type="submit">Create
									Office</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="lightbox-overlay" class=""></div>
		<div id="header-container"></div>
		<div id="stage" class="theme"></div>
		<div id="player-wrapper" class="queue-closed"></div>
	</div>
</body>
</html>