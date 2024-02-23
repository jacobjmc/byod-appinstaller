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
  runScript();
});

const apps = ref<App[]>([]);

const runScript = async () => {
  loading.value = true;
  apps.value = await invoke("apps_installed");
  loading.value = false;
};

const appToInstall = async (installApp: App) => {
  const appIndex = apps.value.findIndex((app) => app.name === installApp.name);
  apps.value[appIndex].installing = true;
  await invoke(installApp.name);
  runScript();
  apps.value[appIndex].installing = false;
};

const loading = ref(false);
</script>

<template>
  <div id="app" class="bg-green-100 h-[200vh]">
    <div class="flex justify-center mx-20 rounded-lg">
      <div class="flex flex-col mt-10 w-full rounded-lg">
        <UButton
          class="h-12 shadow-md"
          color="black"
          :loading="loading"
          @click="runScript()"
          ><p>Check if apps are installed</p></UButton
        >

        <div
          v-if="apps"
          class="grid grid-cols-1 md:grid-cols-4 md:gap-x-6 mt-8"
        >
          <div v-for="app in apps">
            <div
              class="bg-white shadow-md rounded-lg md:-mb-2 h-[200px] max-w-xs justify-center flex flex-wrap pb-4"
            >
              <img class="h-[60px] mt-4" :src="app.image" alt="" />
              <p
                class="basis-full text-center font-semibold text-gray-800 py-5"
              >
                {{ app.name }}
              </p>
              <p
                v-if="app.installed"
                class="w-full mx-5 pt-1 text-center font-semibold bg-green-500 rounded-lg text-white"
              >
                Installed
              </p>

              <p
                v-if="!app.installed"
                class="w-full mx-5 pt-1 text-center font-semibold bg-red-500 rounded-lg text-white"
              >
                Not Installed
              </p>
            </div>

            <UButton
              block
              color="blue"
              :ui="{ rounded: 'rounded-none rounded-b-lg' }"
              v-if="!app.installed"
              :loading="app.installing"
              @click="appToInstall(app)"
              class="px-10"
              ><p class="text-white">
                {{ app.installing ? "Installing..." : "Install" }}
              </p></UButton
            >
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
