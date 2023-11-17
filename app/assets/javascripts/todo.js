
$(".todo.index").ready(() => {
    let today = new Date()
    let dd = today.getDate()
    let mm = today.getMonth() + 1
    let yyyy = today.getFullYear()
    if(dd<10){
        dd='0'+dd
    }
    if(mm<10){
        mm='0'+mm
    }

    today = yyyy+'-'+mm+'-'+dd
    document.getElementById("deadline").setAttribute("min", today)
    document.getElementById("showBy").setAttribute("min", today)
    document.getElementById("deadline").defaultValue = today

    $("#new-todo-form").submit((e) => {
        e.preventDefault()

        const form_data = $('#new-todo-form').serialize()

        if($("input[name=text]").val().trim().length!==0) {
            $.ajax({
                url: '/todo',
                type: 'POST',
                data: form_data,
                success: () => {
                    location.reload()
                },
                error: () => {
                    alert('Something went wrong...')
                }
            })
        }

    })

    $('.is_completed').change((e) => {
        const id = e.target.parentNode.parentNode.getAttribute('key')
        const todo = {
            is_completed: e.target.checked
        }

        $.ajax({
            url: `/todo/${id}`,
            type: 'PUT',
            data: todo,
            success: () => {
                e.target.nextElementSibling.classList.toggle('text-decoration-line-through')
                e.target.parentNode.parentNode.classList.toggle('opacity-50')
            },
            error: () => {
                alert('Something went wrong...')
            }
        })
    })
})
