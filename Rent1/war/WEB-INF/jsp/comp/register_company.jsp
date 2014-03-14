<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<link rel="stylesheet" href="webincludes/css/style.css">
<link rel="stylesheet" href="webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="webincludes/css/rent1.css">

<link rel="stylesheet" href="webincludes/css/production-uri.css">
<link rel="stylesheet" href="webincludes/css/lightboxes-uri.css">
</head>
<body>
	<div id="fb-root"></div>
	<div id="alt-content"></div>
	<div id="main" class="jumbotron masthead home">
		<div id="lightbox-outer" class="">
			<div id="lightbox" class="lightbox-signup" style="width: 320px;">
				<a id="lightbox-close"
					class="close btn btn-rounded btn-icon-only btn-dark" href="/"><i
					class="icon icon-ex-white-outline"></i></a>
				<div id="lightbox-inner">
					<div class="lbcontainer">
						<div id="lightbox-header">
							<h2 class="title">List your company with RENT1</h2>
						</div>
						<form action="/doRegCompany" method="POST">
							<div id="lightbox-content" style="max-height: 450px;">
								<div class="lightbox-content-block">
									<div id="signup-stage-signup" class="signup-stage">
										<div class="control-group">
											<div style="color: #FF0000;">${errorMessage}</div>
											<div class="controls">
												<label class="placeholder-text" for="signup-compName">Company
													Name</label> <input id="signup-compName" class="input-box-text"
													name="signup-compName" type="text" required>
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
												<label class="placeholder-text" for="signup-compEmail">Email
													Address</label> <input id="signup-compEmail"
													name="signup-compEmail"
													class="signup-text placeholder-input" type="text" required>
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
												<label class="placeholder-text" for="signup-compPhone">Phone
													Number </label> <input id="signup-compPhone"
													name="signup-compPhone"
													class="signup-text placeholder-input" placeholder="000-000-0000" type="tel" required>
											</div>
										</div>
										<div id="signup-user-type" class="btn-group"></div>
										<p class="tos">
											By clicking Create, you are agreeing to the <a href="#">RENT1
												Terms of Service</a>
										</p>
									</div>
								</div>
							</div>
							<div id="lightbox-footer">
								<button id="createAcct"
									class="btn btn-large btn-primary btn-fullwidth" type="submit">Create
									Company Account</button>
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
	<div id="sidebar"></div>
	<script type="text/javascript"></script>
	<div id="swfWrapper"></div>
	<div id="tooltip-helper-text-sizing"
		style="z-index: -1; position: absolute; left: -50000px;"></div>
</body>
</html>