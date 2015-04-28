React = require 'react'
talkClient = require '../api/talk'
apiClient = require '../api/client'

# need a project_id, display_name

module?.exports = React.createClass
  displayName: 'CollectionsCreateForm'

  onSubmit: (e) ->
    e.preventDefault()
    form = React.findDOMNode(@).querySelector('form')
    input = form.querySelector('input')

    display_name = input.value
    # project_id = 76 # Snapshot Supernova
    input.value = ''

    collection = {display_name}
    apiClient.type('collections').create(collection).save()
      .then (collection) =>
        console.log "collection created", collection
      .catch (e) ->
        throw new Error('Failed to create collection:', e)

  render: ->
    <div>
      <form onSubmit={@onSubmit} className='collections-create-form'>
        <input placeholder="Collection Name" />
        <button type="submit">Add Collection</button>
      </form>
    </div>
