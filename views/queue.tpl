<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load("visualization", "1", {packages:["corechart"]});
  google.setOnLoadCallback(drawCharts);

  function drawCharts() {
    drawChart({* json_encode(stats['wait']['histogram']) *}, 'wait-chart', 'Jobs / Minute');
    drawChart({* json_encode(stats['run' ]['histogram']) *}, 'run-chart' , 'Jobs / Minute');
  }

  function drawChart(d, id, title) {
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Time');
    data.addColumn('number', title);

    var _data = [];
    for (var i = 0; i < 60; ++i) {
      _data.push([i + ' seconds', d[i] * 60]);
    }
    for (var i = 1; i < 60; ++i) {
      _data.push([i + ' minutes', d[59 + i]]);
    }
    for (var i = 1; i < 24; ++i) {
      _data.push([i + ' hours', d[118 + i] / 60]);
    }
    for (var i = 1; i < 7; ++i) {
      _data.push([i + ' days', d[141 + i] / 1440]);
    }
    data.addRows(_data);

    var options = {
      legend: {position: 'none'},
      chartArea: { width:"80%", height:"80%" }
    };

    var chart = new google.visualization.SteppedAreaChart(document.getElementById(id));
    chart.draw(data, options);
  }
</script>

<div class="subnav subnav-fixed">
  <ul class="nav nav-pills">
    <li class="{* (tab == 'stats')     and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/stats">Stats</a></li>
    <li class="{* (tab == 'running')   and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/running">Running</a></li>
    <li class="{* (tab == 'waiting')   and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/waiting">Waiting</a></li>
    <li class="{* (tab == 'scheduled') and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/scheduled">Scheduled</a></li>
    <li class="{* (tab == 'stalled')   and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/stalled">Stalled</a></li>
    <li class="{* (tab == 'depends')   and 'active' or '' *}"><a href="{*uri_prefix*}/queues/{* queue.name *}/depends">Depends</a></li>
    <li class="{* (tab == 'recurring') and 'active' or ''*}"><a href="{*uri_prefix*}/queues/{* queue.name *}/recurring">Recurring</a></li>
  </ul>
</div>

<div id="alerts" style="margin-top: 40px"></div>

<div class="row">
  <div class="span8">
    <h2><a href="{*uri_prefix*}/queues/{* queue.name *}">{{ queue['name'] }}</a> |
      {{ queue['running']   }} /
      {{ queue['waiting']   }} /
      {{ queue['scheduled'] }} /
      {{ queue['stalled']   }} /
      {{ queue['depends']   }} <small>(running / waiting / scheduled / stalled / depends)</small>
    </h2>
  </div>

  <div class="span4">
    <div style="float:right">
      <h2>
        {{ stats['failed']    }} /
        {{ stats['failures']  }} /
        {{ stats['retries']   }} <small>(failed / failures / retries)</small>
      </h2>
    </div>
  </div>
</div>

{% local tab_list = {running = true, waiting = true, scheduled = true, stalled = true, depends = true, recurring = true } %}
{% if tab and tab_list[tab] and jobs then %}
  <hr/>
    {% for _, job in ipairs(jobs) do %}
      {%
        local new_context = {job = job }
        for k,v in pairs(context) do
          new_context[k] = v
        end
      %}
      {* job_tpl(new_context) *}
    {% end %}
{% else %}
  <div class="row" style="margin-top: 15px">
    <div class="span6">
      <div class="well">
        <div class="row">
          <div class="span12">
            <h3>Waiting</h3>
          </div>
        </div>
        <div class="row">
          <div class="span12">
            <h3>
              {{ stats['wait']['count'] }} /
              {{ string.format('%10.3f', stats['wait']['mean']) }} /
              {{ string.format('%10.3f', stats['wait']['std']) }} <small>Total / Mean / Std. Deviation</small>
            </h3>
          </div>
        </div>
        <div id="wait-chart" class="queue-stats-time-histogram-wait" style="height: 500px"></div>
      </div>
    </div>

    <div class="span6">
      <div class="well">
        <div class="row">
          <div class="span12">
            <h3>Running</h3>
          </div>
        </div>
        <div class="row">
          <div class="span12">
            <h3>
              {{ stats['run']['count'] }} /
              {{ string.format('%10.3f', stats['run']['mean']) }} /
              {{ string.format('%10.3f', stats['run']['std']) }} <small>Total / Mean / Std. Deviation</small>
            </h3>
          </div>
        </div>

        <div id="run-chart"  class="queue-stats-time-histogram-run"  style="height: 500px"></div>
      </div>
    </div>
  </div>
{% end %}
