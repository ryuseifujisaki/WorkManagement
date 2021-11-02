<template>
  <div>
    <AdminHeader></AdminHeader>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Edit</h1>
      <p align="right">管理者専用ページ</p>
      <p align="right">{{ this.userName }}</p>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-data-table :headers="headers" :items="works" @click:row="open">
          </v-data-table>
          <v-dialog v-model="dialog" max-width="600px">
            <v-card-text class="text-center white">
              <v-row>
                <v-col cols="2"></v-col>
                <v-col cols="8">
                  No:{{ this.id }}
                  <br />
                  案件:{{ this.name }}
                  <br />
                  人数:{{ this.limit }}
                  <br />
                  日付:{{ this.day }}
                  <br />
                  場所:{{ this.where }}
                  <br />
                  交通費:{{ this.carfare }}
                  <br />
                  内容:{{ this.content }}
                  <br />
                  服装:{{ this.cloth }}
                  <br />
                  持ち物:{{ this.belonging }}
                  <br />
                  その他:{{ this.other }}
                  <br />
                  <v-btn @click="workdelete">この案件を消去</v-btn>
                </v-col>
                <v-col cols="2"></v-col>
              </v-row>
            </v-card-text>
          </v-dialog>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
import AdminHeader from "@/components/AdminHeader.vue";
export default {
  data() {
    return {
      dialog: false,
      search: "",
      userName: null,
      name: null,
      limit: null,
      day: null,
      where: null,
      carfare: null,
      content: null,
      cloth: null,
      belonging: null,
      other: null,
      works: [],
      work: [],
      headers: [
        {
          text: "No",
          align: "start",
          sortable: "false",
          value: "id",
          width: `3%`,
        },
        {
          text: "Workname",
          align: "start",
          sortable: "false",
          value: "name",
          width: `10%`,
        },
        {
          text: "People limit",
          align: "start",
          sortable: "false",
          value: "limit",
          width: `3%`,
        },
        {
          text: "Day",
          align: "start",
          sortable: "false",
          value: "day",
          width: `15%`,
        },
        {
          text: ":where",
          align: "start",
          sortable: "false",
          value: "where",
          width: `13%`,
        },
        {
          text: ":money",
          align: "start",
          sortable: "false",
          value: "money",
          width: `10%`,
        },
        {
          text: ":carfare",
          align: "start",
          sortable: "false",
          value: "carfare",
          width: `10%`,
        },
        {
          text: ":content",
          align: "start",
          sortable: "false",
          value: "content",
          width: `10%`,
        },
        {
          text: ":cloth",
          align: "start",
          sortable: "false",
          value: "cloth",
          width: `10%`,
        },
        {
          text: ":belonging",
          align: "start",
          sortable: "false",
          value: "belonging",
          width: `10%`,
        },
        {
          text: ":other",
          align: "start",
          sortable: "false",
          value: "other",
          width: `10%`,
        },
      ],
    };
  },
  components: {
    AdminHeader,
  },
  methods: {
    open(row) {
      this.dialog = true;

      this.id = row.id;
      this.name = row.name;
      this.limit = row.limit;
      this.day = row.day;
      this.where = row.where;
      this.money = row.money;
      this.carfare = row.carfare;
      this.content = row.content;
      this.cloth = row.cloth;
      this.belonging = row.belonging;
      this.other = row.other;
    },
    workdelete: function () {
      const url = process.env.VUE_APP_URL;
      axios
        .delete(url + "/works/" + this.id, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log(response);
        });
    },
  },
  mounted: function () {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/current_admin/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.userName = response.data.data.name;
      });
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
        console.log(response);
        this.works = response.data;
      });
  },
};
</script>
