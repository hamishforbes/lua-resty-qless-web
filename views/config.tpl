<div class="page-header">
  <h1>Configuration Settings <small>Including defaults</small></h1>
</div>

{% for key, value in pairs(options) do %}
<div class="row">
  <div class="span4">
    <h2>{{ key }}</h2>
  </div>
  <div class="span8">
    <h2>=> {{ value }}</h2>
  </div>
</div>
{% end %}
