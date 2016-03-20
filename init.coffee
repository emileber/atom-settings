# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.workspace.observeTextEditors (editor) ->
    # sets up middle button scroll on the given editor component
    middleMouseScrollSetup = (editorComponent) ->
        lastClick = {x: 0, y: 0}
        lastPosition = {x: 0, y: 0}

        {scrollViewNode} = editorComponent

        onMouseMove = (event) ->
            [lastPosition.x, lastPosition.y] = [event.x, event.y]

        doScroll = ->
            sensitivity = 0.5

            dx = sensitivity * (lastClick.x - lastPosition.x)
            dy = sensitivity * (lastClick.y - lastPosition.y)

            presenter = editorComponent.presenter

            previousScrollLeft = presenter.getScrollLeft()
            previousScrollTop = presenter.getScrollTop()

            updatedScrollLeft = previousScrollLeft - Math.round(dx)
            updatedScrollTop = previousScrollTop - Math.round(dy)

            presenter.setScrollLeft(updatedScrollLeft)
            presenter.setScrollTop(updatedScrollTop)

        scrollViewNode.addEventListener 'mousedown', (event) ->
            # click with middle button
            if event.button is 1 and process.platform is 'win32'
                [lastClick.x, lastClick.y] = [event.x, event.y]
                [lastPosition.x, lastPosition.y] = [event.x, event.y]

                intervalId = setInterval doScroll, 50
                # console.log(editorComponent.editor.getScrollLeft());


                onMouseUp = ->
                    clearInterval(intervalId)
                    window.removeEventListener 'mousemove', onMouseMove
                    window.removeEventListener 'mouseup', onMouseUp

                window.addEventListener 'mousemove', onMouseMove
                window.addEventListener 'mouseup', onMouseUp

    init = ->
        editorView = atom.views.getView(editor)

        # This keeps track of changes in the editor and adds scrolling if the
        # editor component is changed. This is necessary for various cases when
        # the editor is moved between panes and the componet is changed without
        # triggering `atom.workspace.observeTextEditors`, or in cases when
        # the component is not yet added during the invocation of
        # `atom.workspace.observeTextEditors`
        Object.observe editorView, (changes) ->
            for c in changes
                if c.name == 'component' and c.type == 'update'
                    editorComponent = c.object.component
                    middleMouseScrollSetup(c.object.component) if editorComponent

        editorComponent = editorView.component
        # due to some bug when moving editors between panes,
        # the component might not be defined, in which case the `Object.observe` call
        # above will be invoked once the component is present again
        middleMouseScrollSetup(editorComponent) if editorComponent

    init()
