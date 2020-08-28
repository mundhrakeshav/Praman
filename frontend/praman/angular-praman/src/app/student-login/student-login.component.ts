import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { GetInfoService } from '../services/get-info.service'
import { Router } from '@angular/router';


@Component({
  selector: 'app-student-login',
  templateUrl: './student-login.component.html',
  styleUrls: ['./student-login.component.css']
})
export class StudentLoginComponent implements OnInit {

  public userLoginForm: FormGroup;
  res = <any>{};
  addressId
  constructor(private formBuilder: FormBuilder,private getInfoService: GetInfoService,private route : Router) { }

  ngOnInit(): void {
    this.userLoginForm = this.formBuilder.group({
      uid: ['', [Validators.required]],
      password: ['',[Validators.required]]
    });
  }

  onSubmit(){
    if(this.userLoginForm.valid){
      this.getInfoService.studentLogin(this.userLoginForm.value).subscribe((data) => { 
        this.res = data;
        if(this.res.success === true ){
          localStorage.clear();
          this.route.navigate(["student",this.res.name])
          this.addressId = this.res.address;
          localStorage.setItem("address",this.addressId);
          localStorage.setItem("token",this.res.token);
        }
      });
    }
  }

}
