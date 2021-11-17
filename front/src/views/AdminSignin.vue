<template>
  <div>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Admin Sign in</h1>
      <p align="right">管理者専用ページ</p>
      <p align="right"><a href="/">user signin page</a></p>
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="8">
          <v-card-text class="text-center white">
            <v-text-field label="email" v-model="email"> </v-text-field>
            <br />
            <v-text-field
              label="password"
              v-model="password"
              :type="show1 ? 'text' : 'password'"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show1 = !show1"
            >
            </v-text-field>
            <v-btn @click="submit">管理者ログイン</v-btn>
          </v-card-text>
        </v-col>
        <v-col cols="2"></v-col>
      </v-row>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      email: null,
      password: null,
      show1: false,
    };
  },
  methods: {
    submit: function () {
      const url = process.env.VUE_APP_URL + "/api/admin/sign_in";
      var params = new URLSearchParams();

      params.append("email", this.email);
      params.append("password", this.password);
      axios.defaults.headers.common["Content-Type"] = "application/json";
      axios.post(url, params).then(
        (response) => {
          localStorage.setItem(
            "access-token",
            response.headers["access-token"]
          );
          localStorage.setItem("client", response.headers["client"]);
          localStorage.setItem("uid", response.headers["uid"]);
          localStorage.setItem("token-type", response.headers["token-type"]);
          this.$router.push("/workregister");
        },
        (error) => {
          return error;
        }
      );
    },
  },
};
</script>
