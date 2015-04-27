React = require 'react'
talkClient = require '../api/talk'
CollectionCreateForm = require './create-form'

module?.exports = React.createClass
  displayName: 'Collections'

  getInitialState: ->
    collections: []

  componentWillMount: ->
    @setCollections()

  setCollections: ->
    talkClient.type('collections').get()
      .then (collections) =>
        @setState {collections}
      .catch (e) -> throw new Error('Error collections')

  collection: (d, i) ->
    <div key={i}>{d}</div>

  render: ->
    <div className="collections content-container">
      <h1>Collections</h1>
      <CollectionCreateForm />
      {@state.collections.map(@collection)}
    </div>
