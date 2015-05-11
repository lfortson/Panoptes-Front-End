React = require 'react'
ChangeListener = require '../components/change-listener'
PromiseRenderer = require '../components/promise-renderer'
authClient = require '../api/auth'

module?.exports = React.createClass
  displayName: 'LoggedIn'

  render: ->
    <ChangeListener target={authClient}>{=>
      <PromiseRenderer promise={authClient.checkCurrent()}>{(user) =>
        if user?
          {@props.children}
      }</PromiseRenderer>
    }</ChangeListener>
