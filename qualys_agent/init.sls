{%- set default_sources = {'module' : 'qualys_agent', 'defaults' : True, 'pillar' : True} %}
{%- from "./defaults/load_config.jinja" import config as qualys_agent with context %}

{% if qualys_agent.use is defined %}

{% if qualys_agent.use | to_bool %}

# Do installation
qualys_cloud_agent:
  pkg.installed:
    - name: {{ qualys-cloud-agent.package_name }}
  {% if qualys-cloud-agent.package_file is defined %}
    - sources:
      - {{ qualys-cloud-agent.package_name }}: {{ qualys-cloud-agent.package_file }}
  {% endif %}

#qualys_cloud_agent_install:
#  cmd.run:
#    - name: /path/to/qualys-cloud-agent.sh ActivationId={{ qualys_agent.activation_id }} CustomerId={{ qualys_agent.customer_id }}
#    - require:
#      - pkg: {{qualys-cloud-agent.package_name }}

qualys_cloud_agent_service:
  service.running:
    - name: qualys-cloud-agent
    - enable: True

{% else %}

# Do removal
qualys_cloud_agent_service:
  service.stopped:
    - name: qualys-cloud-agent
    - enable: False

qualys_cloud_agent:
  pkg.removed:
    - name: {{ qualys-cloud-agent.package_name }}

{% endif %}

{% endif %}