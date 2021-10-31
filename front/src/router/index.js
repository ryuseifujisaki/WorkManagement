import Vue from "vue";
import VueRouter from "vue-router";
import Work from "../views/Work.vue";
import Welcome from "../views/Welcome.vue";
import Signup from "../views/Signup.vue";
import WorkRegister from "../views/WorkRegister.vue";
import AdminSignin from "../views/AdminSignin.vue";
import WorkEdit from "../views/WorkEdit.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Welcome",
    component: Welcome,
  },
  {
    path: "/about",
    name: "About",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
  {
    path: "/work",
    name: "Work",
    component: Work,
  },
  {
    path: "/signup",
    name: "Signup",
    component: Signup,
  },
  {
    path: "/workregister",
    name: "WorkRegister",
    component: WorkRegister,
  },
  {
    path: "/adminsignin",
    name: "AdminSignin",
    component: AdminSignin,
  },
  {
    path: "/workedit",
    name: "WorkEdit",
    component: WorkEdit,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
