# README

Esta aplicación de Ruby on Rails está dockerizada, para correrla es necesario tener Docker y correr:
`docker-compose build`
`docker-compose up`
`docker-compose run web rails db:create`
`docker-compose run web rails db:migrate`

La aplicación se monta en `http://localhost:3000/`, para hacer un request la URL es `http://localhost:3000/tasks`, por ejemplo.
Para una descripción de todos los endpoints disponibles revisar `API_DOCUMENTATION.md`

Para correr los tests:
`docker-compose run web rails test`

### Decisiones de diseño

La aplicación es un poco más compleja de lo que quizás una tarea así necesitaba, pero sentí que soluciones
intermedias no eran lo suficientemente completas, y preferí demostrar algo más parecido a lo que hubiera
hecho en mi día a día en un trabajo. 

Por esto implementé:

- Caché: asumí que la asignación de tareas va a ser consultada múltiples veces, por ejemplo porque está en el
inicio de la aplicación. Por esto guardo en base de datos el resultado cuando se calcula, para evitar calcularlo
múltiples veces. Para esto también se hashea el estado actual de la aplicación (las tareas y los empleados disponibles)
para solo retornar un resultado si es que el estado no ha cambiado. Esto tiene algunos falsos positivos (en donde se
vuelve a calcular cuando no era necesario), como por ejemplo si se agrega un empleado, pero dejé eso como "deuda técnica", ya
que asumo que no es algo que va a pasar muy seguido, y nunca se va a dar el caso de que se retorna un valor hasheado que
no corresponda.
- Algoritmo greedy inicial: este algoritmo intenta asignar las tareas partiendo por las tareas más largas a los empleados
con más tiempo. En general encuentra una respuesta, así que es utilizado como primera opción por su rapidez.
- Algoritmo de backtracking: sin embargo el algoritmo greedy no es correcto, y hay casos en los que no encontrará una respuesta. Por esto se implementó un algoritmo de backtracking que corre en el background (para que la API no se quede pegada).