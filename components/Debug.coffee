noflo = require 'noflo'

# @runtime noflo-nodejs

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'bug'
  c.description = 'Debug messages'

  label = 'debug'
  message = ''
  debug = ''

  # Add input ports
  c.inPorts.add 'label',
    datatype: 'string'
    require: yes
    default: 'debug'
  c.inPorts.add 'message',
    datatype: 'string'
    require: yes
  c.inPorts.add 'send',
    datatype: 'bang'
    require: yes

  # Add output ports
  c.outPorts.add 'out',
    datatype: 'string'

  c.inPorts.label.on 'data', (payload) ->
    label = payload
  c.inPorts.message.on 'data', (payload) ->
    message = payload
  c.inPorts.send.on 'data', ->
    debug = new Date().toISOString() + ' : [' + label + ' ] - ' + message
    console.log(debug)
    c.outPorts.out.send debug

  # Finally return the component instance
  c