{% if not (#queues > 0) then %}
  <div class="page-header">
    <h1>No Queues <small>I wish I had some queues :-/</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Queues <small>And their job counts</small></h1>
  </div>

  <table class="table">
    <thead>
      <tr>
        <th></th>
        <th>running</th>
        <th>waiting</th>
        <th>scheduled</th>
        <th>stalled</th>
        <th>depends</th>
        <th>recurring</th>
      </tr>
    </thead>
    <tbody>
    {% for _, queue in pairs(queues) do %}
    <tr class="queue-row">
      <td class="queue-column large-text">
        {% if queue['paused'] then %}
          <button
            id="{{queue['name']}}-pause"
            title="Unpause"
            class="btn btn-success"
            onclick="unpause('{{queue['name']}}')"><i class="icon-play"></i>
          </button>
        {% else %}
          <button
            id="{{queue['name']}}-pause"
            title="Pause"
            class="btn btn-warning"
            onclick="pause('{{queue['name']}}')"><i class="icon-pause"></i>
          </button>
        {% end %}
        <a href="{* uri_prefix *}/queues/{{queue['name']}}">{* queue['name'] *}</a>
      </td>
      <td>{{ queue['running']   }}</td>
      <td>{{ queue['waiting']   }}</td>
      <td>{{ queue['scheduled'] }}</td>
      <td>{{ queue['stalled']   }}</td>
      <td>{{ queue['depends']   }}</td>
      <td>{{ queue['recurring'] }}</td>
    </tr>
  {% end %}
  </tbody>
</table>
{% end %}

{% if not failed then %}
  <div class="page-header">
    <h1>No Failed Jobs <small>Clean as a whistle</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Failed Jobs <small>D'oh!</small></h1>
  </div>

  <table class="table">
    <thead>
      <tr>
        <th>failure</th>
        <th>count</th>
      </tr>
    </thead>
    <tbody>
    {% for t, count in pairs(failed) do %}
    <tr class="failed-row">
      <td class="large-text"><a href="{* uri_prefix *}/failed/{*t*}">{*t*}</a></td>
      <td>{{count}}</td>
    </tr>
    {% end %}
    </tbody>
  </table>
{% end %}

{% if not (#tracked['jobs'] > 0) then %}
  <div class="page-header">
    <h1>No Tracked Jobs <small>These aren't the droids you're looking for</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Tracked Jobs <small>These <i>are</i> the droids you're looking for</small></h1>
  </div>
  {%
    local counts = {}
    for _, job in pairs(tracked['jobs']) do
      if not counts[job.state] then
        counts[job.state] = 0
      else
        counts[job.state] = counts[job.state] + 1
      end
    end
  %}
  <table class="table">
    <thead>
      <tr>
        <th>state</th>
        <th>count</th>
      </tr>
    </thead>
    <tbody>
    {% for state, count in pairs(counts) do %}
    <tr class="tracked-row">
      <td class="large-text"><a href="{* uri_prefix *}/track/{* state *}">{{ state }}</a></td>
      <td>{{ count }}</td>
    </tr>
    {% end %}
    </tbody>
  </table>
{% end %}

{% if not (#workers > 0) then %}
  <div class="page-header">
    <h1>No Workers <small>Nobody's doin' nothin'!</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Current Workers <small>And their job counts</small></h1>
  </div>
  <table class="table">
    <thead>
      <tr>
        <th></th>
        <th>running</th>
        <th>stalled</th>
      </tr>
    </thead>
    <tbody>
    {% for _, worker in pairs(workers) do %}
    <tr class='worker-row'>
      <td class="large-text"><a href="{* uri_prefix *}/workers/{{worker['name']}}">{{ worker['name'] }}</a></td>
      <td>{{ worker['jobs'] }}</td>
      <td>{{ worker['stalled'] }}</td>
    </tr>
    {% end %}
    </tbody>
  </table>
{% end %}
