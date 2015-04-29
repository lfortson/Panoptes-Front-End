React = require 'react'
CollectionCreateForm = require './create-form'
talkClient = require '../api/talk'
apiClient = require '../api/client'
{Link} = require 'react-router'

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

  collectionLink: (d, i) ->
    <div key={i}>
      <Link to="collections-show" params={collection_id: d.id}>
        {d.display_name}
      </Link>
    </div>

  render: ->
    <div className="collections-home">
      <h1>Collections Home</h1>
      <CollectionCreateForm />
      {@state.collections.map(@collectionLink)}
    </div>
