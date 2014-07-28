# @cjsx React.DOM

React = require 'react'
Store = require '../data/store'
{dispatch} = require '../data/dispatcher'
Dialog = require '../components/dialog'
SignInForm = require './sign-in-form'
appActions = require '../actions/app'

loginDialogStore = new Store
  tab: 1

  handlers:
    'login-dialog:switch-tab': (index) ->
      @set 'tab', index

LoginDialog = React.createClass
  displayName: 'LoginDialog'

  mixins: [loginDialogStore.mixInto {'tab'}]

  switchTab: (index) ->
    dispatch 'login-dialog:switch-tab', index

  render: ->
    <Dialog className="columns-container" style={height: '70%'}>
      <div className="tabbed-content column" data-side="top" style={width: 640}>
        <div className="tabbed-content-tabs">
          <button className="tabbed-content-tab #{if @state.tab is 0 then 'selected' else ''}" onClick={@switchTab.bind this, 0}>Sign in</button>
          <button className="tabbed-content-tab #{if @state.tab is 1 then 'selected' else ''}" onClick={@switchTab.bind this, 1}>Register</button>
        </div>

        {if @state.tab is 0
          <SignInForm user={@props.user} className="content-container" />
        else if @state.tab is 1
          <div className="content-container">
            <p>TODO: REGISTER</p>
          </div>}
      </div>

      <hr />

      <div>
        <p>TODO: SOCIAL LOGIN</p>
      </div>

      <div className="dialog-actions">
        <button onClick={appActions.hideLoginDialog}>&times;</button>
      </div>
    </Dialog>

module.exports = LoginDialog