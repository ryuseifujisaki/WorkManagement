<template>
  <div>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Information</h1>
    </v-container>
    <h3 class="text-right justify px-9">ようこそ {{ this.usersName }}</h3>
    <v-row>
      <v-col cols="3"></v-col>
      <v-col cols="6">
        <v-form
          v-for="work in works"
          :key="work.id"
          class="text-center justify-center py-6"
        >
          <v-card>
            <h1>案件{{ work.id }}</h1>
            <br />
            案件:{{ work.name }}
            <br />
            日時: {{ work.day }}
            <br />
            会場:{{ work.where }}
            <br />
            交通費:{{ work.carfare }}
            <br />
            募集人員:{{ work.limit }}
            <br />
            作業内容:{{ work.content }}
            <br />
            服装:{{ work.cloth }}
            <br />
            持ち物:{{ work.belonging }}
            <br />
            <v-spacer class="py-5"></v-spacer>
            <v-btn elevation="10">参加する</v-btn>
            <br />
            <br />
          </v-card>
        </v-form>
      </v-col>
      <v-col cols="3"></v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      works: [],
      usersName: [],
    };
  },
  mounted: function () {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/works", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data);
        this.works = response.data;
      });
    axios
      .get(url + "/api/v1/current_user/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data);
        this.usersName = response.data.name;
      });
  },
};
</script>
