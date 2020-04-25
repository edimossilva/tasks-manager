import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { TasklistListComponent } from './tasklist-list/tasklist-list.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'tasklists', component: TasklistListComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
