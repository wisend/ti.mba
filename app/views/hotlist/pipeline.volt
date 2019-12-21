{{ content() }}
</div>
<div class="alert alert-warning" id="updated" style="display: none;">
    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
    <strong>Updated!</strong> You may need to refresh the page to see new updates
</div>
<div class="pipeline-container">
	{% for category in categories %}
	<div class="category {% if category.jobs|length < 1 %}hidden{% endif %}">
		<ul class="list-group searchable" id="list{{ category.id }}">
			<li class="group-header ingnore-me">
				<h4 class="list-group-item-heading">{{ category.name }}</h4>
				<span class="count"></span> Projects 
				<span class="total"></span>
			</li>
			{% for job in category.jobs %}
				<li class="list-group-item item" data-id="{{ job.id }}" data-value="{{ job.value }}">
                <a class="pull-right text-info" data-target="#modal-ajax" href='{{ url('hotlist/view/' ~ job.id) }}' data-target="#modal-ajax"><span class="arrow-btn pull-right"><i class="fa fa-icon fa-arrow-circle-right"></i></span></a>
                <span class="my-handle"></span>
                <strong>{{ job.title|escape }}</strong> <span class="pull-right">${{ job.value|number }}</span>
                <br>
                <span class="description giveMeEllipsis">{{ job.description|escape }}</span>
                <br>
                {% for user in job.users %}
                <span class="initials u{{ user.details.id }}" data-toggle="tooltip" data-placement="bottom" title="{{ user.details.name }}">{{ user.details.name|initials }}</span>
                {% if id === user.details.id %}
                    {% set cancel = true %}
                {% endif %}
                {% endfor %}
                {% if not cancel %}
                <span class="initials follow" data-toggle="tooltip" data-placement="bottom" title="Follow this job" value="{{ job.id }}">+</span>
                {% endif %}
                {% set cancel = false %}
                <strong class="pull-right">{{ job.customer }}</strong>
               
				</li>
			{% endfor %}
		</ul>
	</div>
	{% endfor %}
</div>
<div id="actions">
	<ul class="action-list" id="lost">
		<li class="action-title">Lost</li>
	</ul>
	<ul class="action-list" id="won">
		<li class="action-title">Won</li>
	</ul>
</div>

<div class="modal fade" id="add">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/hotlist/create" method="POST" role="form" autocomplete="off">               
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Add a Job</h4>
                </div>
                <div class="modal-body">
                    {% for element in newForm %}
                        <div class="form-group">
                            {{ element.label() }}
                            {{ element.render() }}
                        </div>
                        {% endfor %}
                        <strong>Category</strong>
                        <br>
                        <div class="btn-group colors" data-toggle="buttons">
                            {% for category in categories %}
                            <label class="btn btn-primary {% if loop.index0 === 0 %}active{% endif %}">
                                <input type="radio" name="category" value="{{ category.id }}" autocomplete="off" {% if loop.index0 === 0 %}checked="checked"{% endif %}> {{ category.name }}
                            </label>
                            {% endfor %}
                        </div>
                        <br>
                        <br>
                        <strong>Quote Via</strong>
                        <br>
                        <div class="btn-group colors" data-toggle="buttons">
                            {% for type in types %}
                            <label class="btn btn-primary {% if loop.index0 === 0 %}active{% endif %}">
                                <input type="radio" name="type" value="{{ type.id }}" autocomplete="off" {% if loop.index0 === 0 %}checked="checked"{% endif %}> {{ type.name }}
                            </label>
                            {% endfor %}
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="categories">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="/hotlist/categories" method="POST" role="form">				
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Categories</h4>
				</div>
				<div class="modal-body">

                <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Enabled</th>
                            </tr>
                        </thead>
                        <tbody>
                        {% for category in categories %}
                            <tr>
                                <td>{{ category.name }}</td>
                                <td><div class="checkbox">
                                    <label>
                                        <input type="checkbox" value="{{ category.id }}" checked="checked">
                                        Enabled?
                                    </label>
                                </div></td>
                            </tr>
                        {% endfor %}
                        </tbody>
                    </table>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="details">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Modal title</h4>
            </div>
            <div class="modal-body">
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function()
    {
        $(".follow").click(function()
        {
            var quote = $(this).attr('value');
            $.ajax
            ({
                type: "POST",
                url: "/hotlist/follow",
                data: '&quote=' + quote,
                cache: false,
            });
            $(this).before("<span class='initials u{{ id }}' data-toggle='tooltip' data-placement='bottom' title='{{ name }}'>{{ initials }}</span>");
            $(this).hide();
            $('[data-toggle="tooltip"]').tooltip()

        });
    });
</script>

<script type="text/javascript">
$('document').ready(function(){
    var addup = function() {
    $('.list-group').each(function() {
        var sum = 0;
        var count = 0;
        var list = $( this ).attr('id');
        $('#' + list + ' li.item').not('.exclude').each(function() {
            var p = parseFloat($(this).data('value'));
            count += 1;
            sum += p;
        });
        $('#' + list + ' span.total').text('$' + sum.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
        $('#' + list + ' span.count').text(count);
    });
    };
    addup();

{% for category in categories %}
    var list{{ loop.index }} = document.getElementById('list{{ category.id }}');
    var sortable{{ category.id }} = Sortable.create(list{{ loop.index }},{
        group: "quotes",
        animation: 200,
        scroll: true, // or HTMLElement
        handle: '.item',
        filter: ".ignore-me",
        draggable: ".item",
        scrollSensitivity: 60, // px, how near the mouse must be to an edge to start scrolling.
        scrollSpeed: 30, // px
            // dragging started
        onStart: function (/**Event*/evt) {
            $("#actions").css("bottom", "0px");
        },
        onEnd: function () {
            setTimeout(function() {if(updating = true) {
                $("#actions").css("bottom", "-100px");
            }}, 100);
        },

        // dragging ended
        onAdd: function(evt){
            $("#actions").css("bottom", "-100px");
            $.post('/hotlist/updatestatus', {'status': '{{ category.id }}', 'quote': $(evt.item).data('id')})
        }    ,

        onSort: function() {
            addup('list{{ loop.index }}')
        }

    });
{% endfor %}


var sortableFour = Sortable.create(document.getElementById('lost'),{
    group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
        $.post('/hotlist/lost', {'quote': $(evt.item).data('id')});
        setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
        setTimeout(function() {$('#lost .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
        setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
        setTimeout(function() {$('#lost .action-title').html('Lost');}, 1400);
    }
});
var sortableFive = Sortable.create(document.getElementById('won'),{
    group: "quotes",
    filter: ".ignore-me",
    // dragging ended
    onAdd: function(evt){
        $.post('/hotlist/won', {'quote': $(evt.item).data('id')});
        setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-refresh fa-spin"></i>');}, 100);
        setTimeout(function() {$('#won .action-title').html('<i class="fa fa-icon fa-check"></i>');}, 600);
        setTimeout(function() {$("#actions").css("bottom", "-100px");}, 1200);
        setTimeout(function() {$('#won .action-title').html('Won');}, 1400);
    }
});
});
</script>
<script type="text/javascript">
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});
</script>
<style type="text/css">
textarea.form-control.input-large, .editable-input, .control-group.form-group, span.editable-container.editable-inline {
    width: 100%;
}
.page-header {
    margin: 40px 0 0;
}
.pipeline-container {
    width: 100%;
    overflow-x: scroll;
    min-height: 84vh;
}
.category {
    min-width: 400px;
    min-height: 70vh;
    clear: none;
    display: table-cell;
}
li.list-group-item.item {
    width: 100%;
}
label.btn.btn-primary.active {
    background: #607D8B;
    border-color: #607d8b;
}
span.initials {
    background: #9E9E9E;
    padding: 5px;
    color: white;
    font-weight: bold;
    margin: 0 5px 0 0;
    min-width: 2em;
    display: inline-block;
    text-align: center;
    border-radius: 50%;
    cursor: hand;
}

.giveMeEllipsis {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2; /* number of lines to show */
    max-height: 2*2;       /* fallback */
}

ul.discussion {
    padding: 0;
    margin: 0;
}
.list-group li:last-child {
    box-shadow: 0 6px 11px -7px rgba(0,0,0,.2);
}
.list-group {
    box-shadow: none;
    min-height: 120px;
}
.editable-click, a.editable-click {
    display: inline-block;
    color: #434a54;
}
    .arrow-btn {
        height: 4.5em;
        padding-top: 1.7em;
        padding-left: 1em;
        padding-bottom: 2em;
        padding-right: 0em;
    }
    ul#hot, ul#warm, ul#cold {
        display: block;
        background: whitesmoke;
        width: 100%;
    }
    div#actions {
        position: fixed;
        bottom: -100px;
        text-align: center;
        width: 100%;
        background: rgb(66, 66, 66);
        border-top: 1px solid black;
        padding: 12px;
        animation: all 5s;
        transition: 0.3s ease-in;
    }
    #actions li.item{
    	display: none;
    	height: 0px !important;
    	width: 0px !important;
    	overflow: hidden;
    	padding: 0px !important;
    	border: 0px !important;
    	margin: 0px !important;
    }
    ul#lost {
        background: #ce3644;
    }
    ul#won {
        background: #85CE36;
    }
    ul.action-list {
        display: inline-block;
        width: 30%;
        border-radius: 5px;
        color: white;
        font-size: 16px;
        list-style: none;
        margin: 10px;
        padding: 10px;
        animation: all;
        transition: 0.2s ease-in;
        align-self: center;
    }
    li.list-group-item.active {
        border-radius: 0px;
    }
li.group-header {
    padding: 14px;
    background: #8BC34A;
    list-style: none;
    color: white;
}
    .list-group-item-heading {
        color: #ffffff;
    }
    .group-header p {
        color: white;
        margin: 0;
    }
    a {
        color: #808080;
    }
{% set colours = ['#f44336', '#E91E63', '#9C27B0', '#00BCD4', '#FFC107', '#2196F3', '#03A9F4', '#673AB7', '#009688', '#4CAF50', '#8BC34A', '#CDDC39', '#3F51B5', '#FF9800'] %}
{% for user in users %}
    span.u{{ user.id }} {
        background: {{ colours[ loop.index0 ] }} ;
    }
{% endfor %}
</style>
