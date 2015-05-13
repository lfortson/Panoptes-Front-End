React = require 'react'
CollectionCreateForm = require './create-form'
talkClient = require '../api/talk'
apiClient = require '../api/client'
authClient = require '../api/auth'
auth = require '../api/auth'
{Link} = require 'react-router'
ChangeListener = require '../components/change-listener'
PromiseRenderer = require '../components/promise-renderer'

module?.exports = React.createClass
  displayName: 'CollectionsHome'

  getInitialState: ->
    collections: []

  componentWillMount: ->
    @setCollections()

  setCollections: ->
    auth.checkCurrent().then (user) =>
      user.get('collections')
        .then (collections) =>
          @setState {collections}
        .catch (e) -> throw new Error(e)

  collectionLink: (d, i) ->
    <div key={i}>
      <Link to="collections-show" params={collection_id: d.id}>
        {d.display_name}
      </Link>
    </div>

  render: ->
    <div className="collections-home">
      <ChangeListener target={authClient}>{=>
        <PromiseRenderer promise={authClient.checkCurrent()}>{(user) =>
          if user?
            <div>
              <CollectionCreateForm />
              {@state.collections.map(@collectionLink)}
            </div>
        }</PromiseRenderer>
      }</ChangeListener>
    </div>
