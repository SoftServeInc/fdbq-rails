## Table of contents

- [Installation](#installation)
- [Configuration](#configuration)

## Installation

* Add package to a project

  * using Yarn

    `yarn add fdbq`

  * using NPM

    `npm i -S fdbq`

* Add javascript file

  `import "fdbq"`

* Include default theme (optional)

  `import "fdbq/theme.css"`

* Enable on a page

  ```
    var instance = new Fdbq(config);
    instance.init();
  ```

## Configuration

```
{
  mountNode: "body",
  placement: "bottom right",
  modal: {
    title: "Help us get better",
  },
  submit: {
    url: "http://localhost:3000/api/test-feedback"
  },
  subHeader: {
    title: "Feedback",
    description: "Please take a short survey"
  },
  questions: [
    {
      name: "feedback[usage]",
      label: "Please share your feedback upon usage of Practice Dashboard",
      value: "",
      placeholder: "Type here",
      type: "text",
      required: true,
      hint: "Please, describe your opinion about the service we provide."
    }
  ]
}
```

##### Instance configuration

| Setting                  | Required | Type                | Options                          | Default   | Description                   |
| ------------------------ | -------- | ------------------- | -------------------------------- | --------- | ----------------------------- |
| `mountNode`              | No       | String              |                                  |`"body" `  | Root node to mount lugin into |
| `placement`              | Yes      | String              | `bottom`, `top`, `left`, `right` |           | Button placement on a screen  |
| `modal`                  | No       | Object              |                                  |           | Modal settings                |
| `submit`                 | Yes      | Object              |                                  |  `func`   | Modal submit handler. Default handler submit on `url` |
| `subHeader`              | No       | String              |                                  |           | Modal body sub-header         |
| `questions`              | No       | Array[Object]       |                                  | `[]`      | List of questions for a modal |

##### Modal configuration `modal`

| Setting  | Required | Type                | Options                          | Default   | Description |
| -------- | -------- | ------------------- | -------------------------------- | --------- | ----------- |
| `title`  | No       | String              |                                  |`"" `      | Modal title |

##### Modal configuration `subHeader`

| Setting       | Required | Type                | Options                          | Default   | Description            |
| ------------- | -------- | ------------------- | -------------------------------- | --------- | ---------------------- |
| `title`       | No       | String              |                                  |`"" `      | Modal body title       |
| `description` | No       | String              |                                  |`"" `      | Modal body description |

##### Modal configuration `submit`

* as `Function`

  ```
  {
    // ...
    submit: function(fields, instance) {
      console.log(fields, instance);
    },
    // ...
  }
  ```

* as `Object`

| Setting | Required | Type                | Options                          | Default   | Description                                    |
| ------- | -------- | ------------------- | -------------------------------- | --------- | ---------------------------------------------- |
| `url`   | Yes      | String              |                                  |`"" `      | Submit url for the form. (Uses `POST` request) |

##### Modal configuration `questions`

| Setting       | Required | Type    | Options          | Default | Description                                    |
| ------------- | -------- | ------- | ---------------- | ------- | ---------------------------------------------- |
| `name`        | Yes      | String  |                  |         | Name for a input field. Used as submit param   |
| `label`       | Yes      | String  |                  |         | Input field label                              |
| `value`       | No       | String  |                  |         | Default value for the input                    |
| `placeholder` | No       | String  |                  |         | Input placeholder                              |
| `type`        | Yes      | String  | `Text`, `String` |         | Input field type. Rendered in different style  |
| `required`    | No       | Boolean |                  | `false` | Input required flag                            |
| `hint`        | No       | String  |                  |         | Hint text for input field                      |


> Check out a configuration example in `examples/basic/index.html`