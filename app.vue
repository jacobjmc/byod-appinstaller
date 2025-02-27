<script setup lang="ts">
import { invoke } from "@tauri-apps/api/tauri";
import { onMounted } from "vue";

// call rust function
// const showHello = async () => {
//   hello.value == "hello_test"
//     ? (hello.value = "Click for hello")
//     : (hello.value = (await invoke("hello_world")) as string);
// };

type App = {
  name: string;
  installed: boolean;
  image: string;
  installing?: boolean;
};

onMounted(async () => {
  await getInstalledApps();
  // Run the function every 10 seconds
  //setInterval(getInstalledApps, 30000); // 10000 milliseconds = 10 seconds
});

const apps = ref<App[]>([]);

const getInstalledApps = async () => {
  loading.value = true;
  apps.value = await invoke("apps_installed");
  loading.value = false;
};

const installAll = async () => {
  installingAll.value = true;
  apps.value = await invoke("install_all");
  await getInstalledApps();
  installingAll.value = false;
};

const appToInstall = async (installApp: App | any = "app") => {
  if (installApp === "app") {
    installAll();
  } else {
    const appIndex = apps.value.findIndex(
      (app) => app.name === installApp.name
    );
    apps.value[appIndex].installing = true;
    const nap = await invoke(installApp.name);
    console.log(nap);
    if (nap) {
      apps.value[appIndex].installed = true;
    }
    apps.value[appIndex].installing = false;
  }
};

const loading = ref(false);
const installingAll = ref(false);
</script>

<template>
  <div id="app" class="bg-green-100 h-full md:h-[100vh]">
    <div class="flex justify-center mx-20 rounded-lg">
      <div class="flex flex-col mt-4 w-full rounded-lg">
        <div class="flex flex-col md:flex-row">
          <UButton
            icon="i-mdi-application-import"
            color="blue"
            class="h-12 w-fit mr-auto px-10 shadow-md !text-white"
            :loading="loading"
            @click="getInstalledApps()"
            >Check if apps are installed</UButton
          >
          <UButton
            icon="i-heroicons-arrow-down-on-square-stack"
            color="emerald"
            class="h-12 w-fit px-10 ml-auto shadow-md !text-white"
            :loading="installingAll"
            loading-icon="i-eos-icons-installing"
            @click="installAll()"
            >{{ installingAll ? "Installing..." : "Install all apps" }}</UButton
          >
        </div>

        <div
          v-if="apps"
          class="grid grid-cols-1 md:grid-cols-4 md:gap-x-4 space-y-6 place-items-center md:place-items-baseline justify-content-center"
        >
          <div v-for="app in apps">
            <div
              class="bg-white shadow-md rounded-lg md:-mb-2 h-[200px] max-w-[217px] justify-center flex flex-wrap pb-4"
            >
              <img class="max-h-[60px] mt-4" :src="app.image" alt="" />
              <p
                class="basis-full text-center font-semibold text-gray-800 py-5"
              >
                {{ app.name }}
              </p>
              <UButton
                color="green"
                icon="i-heroicons-check-circle"
                class="!text-white cursor-default hover:!bg-green-400"
                v-if="app.installed"
              >
                Installed
              </UButton>

              <UButton
                icon="i-mdi-alert-circle-outline"
                color="red"
                v-if="!app.installed"
                class="!text-white cursor-default hover:!bg-red-400"
              >
                Not Installed
              </UButton>
            </div>

            <UButton
              block
              color="blue"
              :ui="{
                rounded: 'rounded-none rounded-b-lg',
                icon: { loading: 'animate-none' },
              }"
              v-if="!app.installed"
              :loading="app.installing"
              loading-icon="i-eos-icons-installing"
              @click="appToInstall(app)"
              class="px-10 !text-white"
            >
              {{ app.installing ? "Installing..." : "Install" }}
            </UButton>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style>
#app {
  color: black;
}
</style>
