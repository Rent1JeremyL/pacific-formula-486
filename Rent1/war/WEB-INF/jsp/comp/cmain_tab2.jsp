<%@page contentType="text/html;charset=UTF-8" language="java"%>
<div id="cTab2">
	<div class="row" style="padding: 6px; margin-left: 20px">
		<div>
			<a id="createOffice" class="btn" style="margin: 10px 0px 3px 0px;"
				href="/company/add/office">Create new office</a>
		</div>
		<div class="boxed-group">
			<h3>Offices</h3>
			<div class="boxed-group-inner">
				<ul class="boxed-group-list standalone">
					<%
						if (offices != null) {
							for (Office office : offices) {
					%>
					<li class="clearfix"><strong><%=office.toString()%></strong> <a
						class="btn btn-small minibutton" data-method="post"
						data-confirm="Are you POSITIVE you want to delete this office? You will lose all associated equipment."
						href="/delete/office?id=<%=office.getId()%>">Delete</a></li>
					<hr>
					<%
						}
						}
					%>
				</ul>
			</div>
		</div>
	</div>
</div>