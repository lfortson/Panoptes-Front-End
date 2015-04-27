React = require 'react'

# need a project_id, display_name

module?.exports = React.createClass
  displayName: 'CollectionsCreateForm'

  onSubmit: (e) ->
    e.preventDefault()
    form = React.findDOMNode(@).querySelector('form')
    input = form.querySelector('input')

    input.value = ''

  render: ->
    <div>
      <form onSubmit={@onSubmit} className='collections-create-form'>
        <input placeholder="Collection Name" />
        <button type="submit">Add Collection</button>
      </form>
    </div>
