<template>
  <header id="header" class="mb-15">
    <v-navigation-drawer app v-model="drawer">
      <v-container>
        <v-list-item>
          <v-list-item-content>
            <v-list-item-title class="title">
              menu
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
        <v-list dense nav>
          <v-list-item v-for="nav_list in nav_lists" :key="nav_list.name">
            <v-list-item-icon>
              <v-icon>{{ nav_list.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ nav_list.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-container>
    </v-navigation-drawer>
    <v-app-bar color="#F9A825" dark app>
      <v-app-bar-nav-icon @click="drawer=!drawer"></v-app-bar-nav-icon>
      <v-btn text>trima</v-btn>
      <!-- <v-toolbar-title>trima</v-toolbar-title> -->
      <v-spacer></v-spacer>
      <v-btn text>How to Use</v-btn>
      <v-btn text>Sign Up</v-btn>
    </v-app-bar>
  </header>
</template>

<script>
  export default {
    name: 'Header',
    data: function () {
      return {
        drawer: null,
        nav_lists:[
          {name: 'Home',icon: 'mdi-account'},
          {name: 'About trima',icon: 'mdi-account'},
          {name: '国内観光事業者の方',icon: 'mdi-account-group'},
          {name: 'About us',icon: 'mdi-cart-arrow-down'},
          {name: 'Sign In',icon: 'mdi-account-cog'},
          {name: 'Sign Up',icon: 'mdi-account-cog'},
        ]
      }
    }
  }
</script>
