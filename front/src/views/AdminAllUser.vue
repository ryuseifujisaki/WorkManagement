<template>
  <div>
    <!--ヘッダー表示-->
    <AdminHeader></AdminHeader>
    <!--全user情報表示-->
    <v-container class="text-center justify-center py-6">
      <h1>All User Information</h1>
      <p align="right">管理者専用ページ</p>
      <p align="right">{{ this.userName }}</p>
      <p align="right"><a href="/">user signin page</a></p>
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="8">
          <!-- 検索用のテキスト入力 -->
          <v-text-field
            v-model="search"
            append-icon="mdi-magnify"
            label="検索"
            single-line
            hide-details
          ></v-text-field>
          <v-data-table
            dense
            :headers="headers"
            :items="users"
            :search="search"
            @click:row="open"
          >
          </v-data-table>
        </v-col>
        <v-col cols="2"></v-col>
      </v-row>
    </v-container>
    <v-row>
      <v-col cols="2"></v-col>
      <v-col cols="8">
        <!--deleteダイアログ-->
        <v-dialog v-model="dialog" width="600px">
          <v-card>
            <div class="text-center">
              <h4>user delete</h4>
              name:{{ this.name }} <br />
              email:{{ this.email }}<br />
              grade:{{ this.grade }}<br />
              course:{{ this.course }} <br />
              tel:{{ this.tel }}<br />
              <v-btn @click="openconfirm" elevation="13" color="error"
                >このユーザーを消去しますか？</v-btn
              >
              <v-dialog v-model="confirmdialog" width="600px">
                <v-card color="white">
                  <div class="text-center">
                    <h2>本当によろしいですか？</h2>
                    <div class="btnspace">
                      <v-btn color="error" @click="userdelete">消去</v-btn>
                    </div>
                  </div>
                </v-card>
              </v-dialog>
            </div>
          </v-card>
        </v-dialog>
      </v-col>
      <v-col cols="2"></v-col>
    </v-row>
  </div>
</template>
<script>
import axios from "axios";
import AdminHeader from "@/components/AdminHeader.vue";
export default {
  data() {
    return {
      users: [],
      search: null,
      name: null,
      grade: null,
      course: null,
      email: null,
      tel: null,
      userName: null,
      dialog: false,
      confirmdialog: false,
      headers: [
        {
          text: "name",
          align: "start",
          sortable: "false",
          value: "name",
        },
        {
          text: "grade",
          align: "start",
          sortable: "false",
          value: "grade",
        },
        {
          text: "course",
          align: "start",
          sortable: "false",
          value: "course",
        },
        {
          text: "email",
          align: "start",
          sortable: "false",
          value: "email",
        },
        {
          text: "tel",
          align: "start",
          sortable: "false",
          value: "tel",
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
      this.grade = row.grade;
      this.course = row.course;
      this.email = row.email;
      this.tel = row.tel;
    },
    openconfirm() {
      this.dialog = false;
      this.confirmdialog = true;
    },
    userdelete: function () {
      const url = process.env.VUE_APP_URL;
      var params = {
        id: this.id,
      };
      axios
        .put(url + "/api/v1/current_user/user_delete", params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log(response);
          location.reload();
        });
    },
  },
  mounted: async function () {
    const url = process.env.VUE_APP_URL;
    //直アクセス禁止
    axios
      .get(url + "/api/v1/current_admin/get_admin_signin", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.flag = response.data.flag;
        if (this.flag == false) {
          this.$router.push("/adminsignin");
        }
      });
    //全User情報取得
    axios
      .get(url + "/api/v1/current_user/index", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data.data);
        this.users = response.data.data;
      });
    //adminuser情報取得
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
  },
};
</script>
<style>
.btnspace {
  display: flex;
  justify-content: space-around;
}
</style>
