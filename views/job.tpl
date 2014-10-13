<script>
var fade = function(jid, type) {
  if (type == 'cancel') {
    $('#job-' + jid).slideUp();
  }
}
</script>

{% if job then %}
    {%
        local new_context = {job = job }
        for k,v in pairs(context) do
            new_context[k] = v
        end
    %}
    {* job_tpl(new_context) *}
{% else %}
  <div class="row">
    <div class="span12">
      <h2>{{ jid }} doesn't exist, was canceled, or expired</h2>
    </div>
  </div>
{% end %}
