noflo = require 'noflo'
url = require 'url'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'filter'
  c.description = ''

  resource = ''
  request = null

  # Add input ports
  c.inPorts.add 'resource',
    datatype: 'string'
    require: yes
  c.inPorts.add 'request',
    datatype: 'object'
    require: yes
  
  # Add output ports
  c.outPorts.add 'out',
    datatype: 'string'

  c.inPorts.resource.on 'data', (payload) ->
    resource = payload
  c.inPorts.request.on 'data', (payload) ->
    request = payload
    req = url.parse(request.url)
    if req.path is resource
      c.outPorts.out.send request.payload

  # Finally return the component instance
  c