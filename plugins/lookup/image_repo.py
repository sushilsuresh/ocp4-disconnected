# python 3 headers, required if submitting to Ansible
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = """
        lookup: file
        author: Daniel Hokka Zakrisson <daniel@hozac.com>
        version_added: "0.9"
        short_description: read file contents
        description:
            - This lookup returns the contents from a file on the Ansible controller's file system.
        options:
          _terms:
            description: path(s) of files to read
            required: True
        notes:
          - if read in variable context, the file can be interpreted as YAML if the content is valid to the parser.
          - this lookup does not understand globing --- use the fileglob lookup instead.
"""
from ansible.errors import AnsibleError, AnsibleParserError
from ansible.module_utils._text import to_text
from ansible.plugins.lookup import LookupBase
from ansible.utils.display import Display

display = Display()


class LookupModule(LookupBase):

    def run(self, terms, variables=None, **kwargs):


        # lookups in general are expected to both take a list as input and output a list
        # this is done so they work with the looping construct 'with_'.
        ret = []

        image = kwargs['image']
        try:
            if '@' in image:
                repo = image.split('@')[0]
                ret.append(to_text(repo))
            elif ':' in image:
                repo = image.split(':')[0]
                ret.append(to_text(repo))
            else:
                ret.append(to_text(image))
        except AnsibleParserError:
            raise AnsibleError("could not locate file in lookup: %s" % term)
        return ret
