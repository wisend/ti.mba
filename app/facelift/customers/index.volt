<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">Search Customers</h4>
			</div>
			<div class="col text-right">
				{{ linkTo(['customers/new', 'New', 'class': 'btn btn-primary']) }}
			</div>
			<hr />
		</div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col">
			{{ flashSession.output() }}
			{{ content() }}
		</div>
	</div>
</div>

<div class="container bg-white py-3 mb-4 border shadow-sm rounded">
	<table class="table table-striped table-hover dataTable bg-white" data-source="{{ url('customers/index') }}">
		<thead>
			<tr>
				<th>Code</th>
				<th>Customer Name</th>
				<th>Phone</th>
				<th>Fax</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
			<tr>
				<th>Code</th>
				<th>Customer Name</th>
				<th>Phone</th>
				<th>Fax</th>
				<th>Status</th>
			</tr>
		</tfoot>
	</table>

	<script src="https://ats.ti.mba/js/datatables/companies.js"></script>
