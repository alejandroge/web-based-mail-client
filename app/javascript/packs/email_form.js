/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

import MarkdownIt from 'markdown-it'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#app',
    data: () => {
      return {
        to: null,
        subject: null,
        body: null,
        markdownParser: null,
      }
    },
    computed: {
      compiledMarkdown() {
        return this.markdownParser && this.markdownParser.render(this.body)
      },
    },
    mounted() {
      this.markdownParser = new MarkdownIt()
    },
    methods: {
      sendEmail() {
        console.log('button clicked')
        console.log(this.body)
      },
    },
  })
})
