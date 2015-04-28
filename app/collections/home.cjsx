React = require 'react'
CollectionCreateForm = require './create-form'
talkClient = require '../api/talk'
apiClient = require '../api/client'

module?.exports = React.createClass
  displayName: 'CollectionsHome'

  getInitialState: ->
    collections: []

  componentWillMount: ->
    @setCollections()

  setCollections: ->
    talkClient.type('collections').get()
      .then (collections) =>
        @setState {collections}
      .catch (e) -> throw new Error('Error getting collections', e)

  collection: (d, i) ->
    <div key={i}>{d.id}</div>

  render: ->
    <div className="collections-home">
      <h1>Collections Home</h1>
      <CollectionCreateForm />
      {@state.collections.map(@collection)}
    </div>
