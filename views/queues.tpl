{% if not queues then %}
  <div class="page-header">
    <h1>No Queues <small>I wish I had some queues :-/</small></h1>
  </div>
{% else %}
  <div class="page-header">
    <h1>Queues <small>And their job counts</small></h1>
  </div>

  {% for _, queue in ipairs(queues) do %}
  <div class="row">
    <div class="span4">
      <h3>
        {% if queue['paused'] then %}
          <button
            id="{* queue['name'] *}-pause"
            title="Unpause"
            class="btn btn-success"
            onclick="unpause('{* queue['name'] *}')"><i class="icon-play"></i>
          </button>
        {% else %}
          <button
            id="{* queue['name'] *}-pause"
            title="Pause"
            class="btn btn-warning"
            onclick="pause('{* queue['name'] *}')"><i class="icon-pause"></i>
          </button>
        {% end %}
        <a href="{* uri_prefix .. "/queues/" .. queue['name'] *}">{{ queue['name'] }}</a>
      </h3>
    </div>
    <div class="span8">
      <h3> |
        {{ queue['running']   }} /
        {{ queue['waiting']   }} /
        {{ queue['scheduled'] }} /
        {{ queue['stalled']   }} /
        {{ queue['depends']   }} <small>(running / waiting / scheduled / stalled / depends)</small>
      </h3>
    </div>
  </div>
  {% end %}
{% end %}
