#!/usr/bin/env python3.6

import os
from ruamel import yaml
from jinja2 import Environment, FileSystemLoader
 
PATH = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_ENVIRONMENT = Environment(
    autoescape=False,
    loader=FileSystemLoader(os.path.join(PATH)),
    trim_blocks=False)
 
with open('swag/generated.yml') as f:
  swag = yaml.safe_load(f)

def render_template(template_filename, context):
    return TEMPLATE_ENVIRONMENT.get_template(template_filename).render(context)


def create_index_html():
    fname = "server.tmp"
    #
    for path, obj in swag['paths'].items():
        if 'x-amazon-apigateway-any-method' in obj:
            if 'x-amazon-apigateway-integration' in obj['x-amazon-apigateway-any-method']:
                if obj['x-amazon-apigateway-any-method']['x-amazon-apigateway-integration']['type'] == 'aws_proxy':
                    uri = obj['x-amazon-apigateway-any-method']['x-amazon-apigateway-integration']['uri']
                    print(uri)
                    uri_spl = uri.split('/')[3]
                    print(uri_spl)
                    swag[path]['x-amazon-apigateway-any-method']['x-amazon-apigateway-integration'] = uri_spl
    context = {
        'data': swag
    }
        
    with open(fname, 'w') as f:
        html = render_template('server.jinja', context)
        f.write(html)
 
 
def main():
    create_index_html()
 
########################################
 
if __name__ == "__main__":
    main()
