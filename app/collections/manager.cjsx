React = require 'react'
apiClient = require '../api/client'

module?.exports = React.createClass
  displayName: 'CollectionsManager'

  componentWillMount: ->
    console.log "@props.subject of CM", @props.subject
    @setCollections()

  setCollections: ->
    apiClient.type('collections').get()
      .then (collections) =>
        console.log "collections", collections

  render: ->
    <div className="collections-manager">
      <h1>Collections Manager</h1>
      <p>A bunch of toggleable buttons or checkboxes</p>
    </div>
  
