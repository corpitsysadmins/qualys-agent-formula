{%- set default_sources = {'module' : 'qualys_agent', 'defaults' : True, 'pillar' : True} %}
{%- from "./defaults/load_config.jinja" import config as qualys_agent with context %}

{% if qualys_agent.use is defined %}

{% if qualys_agent.use | to_bool %}

# Do installation

{% else %}

# Do removal

{% endif %}

{% endif %}